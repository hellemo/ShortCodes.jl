abstract type AbstractDOI <: ShortCode end
struct EmDOI{T<:AbstractString} <: AbstractDOI
    doi::T
    highlight::T # Author to highlight when displaying
end
struct DOI{T<:AbstractString} <: AbstractDOI
    doi::T
end
struct ShortDOI{T<:AbstractString} <: AbstractDOI
    shortdoi::T
    ShortDOI(doi::String) =
        length(doi) > 10 ? new{String}(shortdoi(DOI{String}(doi))) : new{String}(doi)
end
DOI(doi::String) = DOI{String}(doi)
EmDOI(doi::String) = EmDOI{String}(doi, "")
EmDOI(doi::AbstractDOI, em::AbstractString) = EmDOI(doi.doi, em)
ShortDOI(doi::AbstractDOI) = ShortDOI(shortdoi(doi))

function Base.getproperty(obj::AbstractDOI, sym::Symbol)
    sym == :doi && return getdoi(obj)
    sym == :year && return year(obj.pub_date)
    sym == :citation_count && return fetch_citation_count(getdoi(obj))
    if sym == :journal
        return strip(obj.venue)
    elseif sym in [:author, :title, :page, :pub_date, :venue]   # string types
        return fetch_metadata(obj)[string(sym)]
    elseif sym in [:volume, :citation_count, :issue] # integer types
        return parse(Int, fetch_metadata(obj)[string(sym)])
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
    rj = Dict(f => "" for f in fields)
    rj["id"] = doi
    return rj
end

@memoize function fetch_metadata(doi::AbstractDOI)
    fetch_metadata(doi.doi)
end
@memoize function fetch_metadata(doi_string)
    r = http_get("https://w3id.org/oc/meta/api/v1/metadata/doi:$(doi_string)")
    rj = JSON.parse(r)
    if isempty(rj)
        return metadata_template(doi)
    else
        return first(rj)
    end
end
fetch_citation_count(doi::AbstractDOI) = fetch_citation_count(doi.doi)
@memoize function fetch_citation_count(doi_string)
    rj = JSON.parse(
        http_get("https://opencitations.net/index/api/v1/citation-count/$(doi_string)"),
    )
    return parse(Int, rj[1].count)
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
function format_authors(authors, author = "XXXXX", em = "b")

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
    return join(names, ",", " and")
end

function emph_author(some_author, em_author = "", em = "b")
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
        return ", cited by $(fetch_citation_count(getdoi(doi)))"
    else
        return ""
    end
end
