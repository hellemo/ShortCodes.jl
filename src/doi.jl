abstract type AbstractDOI <: ShortCode end
struct EmDOI{T<:AbstractString} <: AbstractDOI
    doi::T
    highlight::T # Author to highlight when displaying
    backend::Symbol
end
struct DOI{T<:AbstractString} <: AbstractDOI
    doi::T
    backend::Symbol
end
struct ShortDOI{T<:AbstractString} <: AbstractDOI
    shortdoi::T
    backend::Symbol
    ShortDOI(doi::String; backend=:opencitations) =
        length(doi) > 10 ? new{String}(shortdoi(DOI(doi; backend)), backend) :
        new{String}(doi, backend)
end

const DOI_BACKENDS = (:opencitations, :openalex)

function validate_backend(backend)
    backend in DOI_BACKENDS ||
        throw(ArgumentError("Unsupported DOI backend: $(repr(backend)). Use :opencitations or :openalex."))
    backend
end

DOI(doi::String; backend=:opencitations) =
    DOI{String}(doi, validate_backend(backend))
EmDOI(doi::String; backend=:opencitations) =
    EmDOI{String}(doi, "", validate_backend(backend))
EmDOI(doi::AbstractDOI, em::AbstractString; backend=doi.backend) =
    EmDOI{String}(String(doi.doi), String(em), validate_backend(backend))
EmDOI(doi::String, em::String; backend=:opencitations) =
    EmDOI{String}(doi, em, validate_backend(backend))
ShortDOI(doi::AbstractDOI) = ShortDOI(shortdoi(doi); backend=doi.backend)

function Base.getproperty(obj::AbstractDOI, sym::Symbol)
    sym == :doi && return getdoi(obj)
    sym == :year && return year(obj.pub_date)
    sym == :citation_count && return fetch_citation_count(obj)
    if sym == :journal
        return strip(obj.venue)
    elseif sym in [:author, :title, :page, :pub_date, :venue]   # string types
        return fetch_metadata(obj)[string(sym)]
    elseif sym in [:volume, :issue] # integer types
        return parse_int_or_empty(fetch_metadata(obj)[string(sym)])
    elseif sym == :reference                                # DOI type
        return split(fetch_metadata(obj)[string(sym)], ";") .|>
               x -> DOI(replace(x, " " => ""))
    else # fallback to getfield
        return getfield(obj, sym)
    end
end
getdoi(obj::AbstractDOI) = getfield(obj, :doi)
getdoi(obj::ShortDOI) = expand(obj)

function Base.show(io::IO, ::MIME"text/plain", doi::AbstractDOI)
    print(
        io,
        join((strip(doi.author), doi.title, string(doi.pub_date), format_doi(doi)), " "),
    )
end

function Base.show(io::IO, ::MIME"text/html", doi::AbstractDOI)
    print(
        io,
        "<div>$(format_authors(doi)) <em>$(doi.title)</em>, $(doi.journal) ($(doi.year))
<a href=https://doi.org/$(format_doi(doi))>$(format_doi(doi))</a>$(format_citations(doi))</div>",
    )
end

function Base.show(io::IO, ::MIME"text/html", dois::Array{T} where {T<:AbstractDOI})
    print(io, "<ol>")
    for doi in dois
        print(
            io,
            "<li>$(format_authors(doi)) <em>$(doi.title)</em>, $(doi.journal) ($(doi.year))
  <a href=https://doi.org/$(format_doi(doi))>$(format_doi(doi))</a>$(format_citations(doi))</li>",
        )
    end
    print(io, "</ol>")
end

"""
    meta-data structure from API: https://w3id.org/oc/meta/api/v1/metadata/
"""
function metadata_template(doi::String)
    fields = (
        :publisher,
        :pub_date,
        :page,
        :venue,
        :issue,
        :editor,
        :author,
        :id,
        :volume,
        :title,
        :type,
    )
    rj = Dict(string(f) => "" for f in fields)
    rj["id"] = doi
    return rj
end

@memoize function fetch_metadata(doi::AbstractDOI)
    fetch_metadata(doi.doi, doi.backend)
end

@memoize function fetch_metadata(doi_string, backend::Symbol)
    backend == :openalex && return fetch_openalex_metadata(doi_string)
    fetch_opencitations_metadata(doi_string)
end

@memoize function fetch_opencitations_metadata(doi_string)
    r = http_get("https://w3id.org/oc/meta/api/v1/metadata/doi:$(doi_string)")
    rj = JSON.parse(r)
    if isempty(rj)
        return metadata_template(doi_string)
    else
        return first(rj)
    end
end

function openalex_url(doi_string)
    "https://api.openalex.org/works/https://doi.org/$(doi_string)"
end

string_or_empty(value) = value === nothing ? "" : string(value)
dict_or_empty(value) = value isa AbstractDict ? value : Dict{String,Any}()
vector_or_empty(value) = value === nothing ? Any[] : value
parse_int_or_empty(value) = isempty(value) ? value : parse(Int, value)

function openalex_authors(authorships)
    join(
        (
            string_or_empty(
                get(dict_or_empty(get(authorship, "author", nothing)), "display_name", ""),
            ) for
            authorship in authorships
        ),
        ";",
    )
end

function normalize_openalex_metadata(work, doi_string)
    location = dict_or_empty(get(work, "primary_location", nothing))
    source = dict_or_empty(get(location, "source", nothing))
    biblio = dict_or_empty(get(work, "biblio", nothing))
    first_page = string_or_empty(get(biblio, "first_page", ""))
    last_page = string_or_empty(get(biblio, "last_page", ""))
    page = isempty(last_page) ? first_page : "$(first_page)-$(last_page)"
    year = string_or_empty(get(work, "publication_year", ""))
    publication_date = string_or_empty(get(work, "publication_date", year))
    metadata = metadata_template(doi_string)
    metadata["id"] = "$(string_or_empty(get(work, "id", ""))) doi:$(doi_string)"
    metadata["title"] = string_or_empty(get(work, "title", ""))
    metadata["author"] = openalex_authors(vector_or_empty(get(work, "authorships", Any[])))
    metadata["pub_date"] = isempty(publication_date) ? string(year) : publication_date
    metadata["venue"] = string_or_empty(get(source, "display_name", ""))
    metadata["volume"] = string_or_empty(get(biblio, "volume", ""))
    metadata["issue"] = string_or_empty(get(biblio, "issue", ""))
    metadata["page"] = page
    metadata["publisher"] = string_or_empty(get(source, "host_organization_name", ""))
    metadata["type"] = string_or_empty(get(work, "type", ""))
    metadata
end

@memoize function fetch_openalex_metadata(doi_string)
    work = JSON.parse(http_get(openalex_url(doi_string)))
    normalize_openalex_metadata(work, doi_string)
end

fetch_citation_count(doi::AbstractDOI) = fetch_citation_count(doi.doi, doi.backend)
@memoize function fetch_citation_count(doi_string, backend::Symbol)
    backend == :openalex && return fetch_openalex_citation_count(doi_string)
    fetch_opencitations_citation_count(doi_string)
end

@memoize function fetch_opencitations_citation_count(doi_string)
    rj = JSON.parse(
        http_get("https://opencitations.net/index/api/v1/citation-count/$(doi_string)"),
    )
    return parse(Int, rj[1].count)
end

@memoize function fetch_openalex_citation_count(doi_string)
    work = JSON.parse(http_get(openalex_url(doi_string)))
    get(work, "cited_by_count", 0)
end

@memoize shortdoi(doi::AbstractDOI) = fetch_shortdoi(doi).ShortDOI

@memoize function fetch_shortdoi(doi::AbstractDOI)
    fetch_shortdoi(doi.doi)
end

@memoize function fetch_shortdoi(doi_string::String)
    return JSON.parse(http_get("https://shortdoi.org/$(doi_string)?format=json"))
end
"""
    expand(doi::ShortDOI)

Get full DOI from doi.org
"""
@memoize function expand(doi::ShortDOI)
    r = http_get("https://doi.org/api/handles/$(doi.shortdoi)")
    return JSON.parse(r).values[2].data.value
end


"""
    format_author(authors, author="", em="b")

Add emphasis to selected author display (e.g. for CV use)
"""
format_authors(doi::AbstractDOI) = format_authors(doi.author)
format_authors(doi::EmDOI) = format_authors(doi.author, doi.highlight)
function format_authors(authors, author="XXXXX", em="b")

    orcid1 = r", \d{4}-\d{4}-\d{4}-\d{4}"
    authors = replace(authors, orcid1 => "")
    orcid2 = orcid1 = r"\s?orcid:\d{4}-\d{4}-\d{4}-\d{4}\s?"
    authors = replace(authors, orcid2=>"")
    omidra = r"\s?\[omid:ra/\d*\]"
    authors = replace(authors, omidra => "")

    if length(authors) > 2
        names = split(authors, ";")
        names = emph_author.(names, author, em)
        if length(names) > _use_N_authors()
            names = first(names, _use_N_authors())
            push!(names, " et al.")
            return join(names, ",", "")
        end
    end
    return join(names, ",", " and ")
end

function emph_author(some_author, em_author="", em="b")
    names = split(some_author, ",")
    if contains(first(names), em_author)
        return "<$em>$some_author</$em>"
    end
    return some_author
end

function strip(s)
    return replace(s, r" \[(.*?)\]" => "")
end

function year(s)
    return !isempty(s) && s != "" ? parse(Int, first(s, 4)) : s
end

# Set default formatting of DOI
_use_short_doi(doi) = true
_use_citations(doi) = true
_use_N_authors() = typemax(Int)
function format_doi(doi)
    if _use_short_doi(doi)
        return shortdoi(doi)
    else
        return doi.doi
    end
end

function format_citations(doi)
    if _use_citations(doi)
        return ", cited by $(fetch_citation_count(doi))"
    else
        return ""
    end
end
