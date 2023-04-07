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
        return fetch_metadata(obj)[sym]
    elseif sym in [:volume, :citation_count, :issue] # integer types
        return parse(Int, fetch_metadata(obj)[sym])
    elseif sym == :reference                                # DOI type
        return split(fetch_metadata(obj)[sym], ";") .|> x -> DOI(replace(x, " " => ""))
    else # fallback to getfield
        return getfield(obj, sym)
    end
end
getdoi(obj::AbstractDOI) = getfield(obj, :doi)
getdoi(obj::ShortDOI) = expand(obj)

function Base.show(io::IO, ::MIME"text/plain", doi::AbstractDOI)
    print(io, join((doi.author, doi.title, string(doi.pub_date), shortdoi(doi)), " "))
end

function Base.show(io::IO, ::MIME"text/html", doi::AbstractDOI)
    print(
        io,
        "<div>$(emph_author(doi)) <em>$(doi.title)</em>, $(doi.journal) ($(doi.year))
<a href=https://doi.org/$(shortdoi(doi))>$(shortdoi(doi))</a>, cited by $(fetch_citation_count(getdoi(doi)))</div>",
    )
end

function Base.show(io::IO, ::MIME"text/html", dois::Array{T} where {T<:AbstractDOI})
    print(io, "<ol>")
    for doi in dois
        print(
            io,
            "<li>$(emph_author(doi)) <em>$(doi.title)</em>, $(doi.journal) ($(doi.year))
  <a href=https://doi.org/$(shortdoi(doi))>$(shortdoi(doi))</a>, cited by $(fetch_citation_count(getdoi(doi)))</li>",
        )
    end
    print(io, "</ol>")
end

"""
    meta-data structure from API: https://w3id.org/oc/meta/api/v1/metadata/
""" function metadata_template(doi::String)
    fields = (:publisher, :pub_date, :page, :venue, :issue, :editor, :author, :id, :volume, :title, :type)
    r1 = Dict(f=>"\u0000" for f in fields)
    r1[:id] = doi
    return r1
end

@memoize function fetch_metadata(doi::AbstractDOI)
    fetch_metadata(doi.doi)
end
@memoize function fetch_metadata(doi)
    r = HTTP.get("https://w3id.org/oc/meta/api/v1/metadata/doi:$(doi)")
    rj = JSON3.read(r.body)
    if isempty(rj)
        return metadata_template(doi)
    else
        return rj[1]
    end
end
fetch_citation_count(doi::AbstractDOI) = fetch_citation_count(doi.doi)
@memoize function fetch_citation_count(doi)
    r = HTTP.get("https://opencitations.net/index/api/v1/citation-count/$(doi)")
    rj = JSON3.read(r.body)
    return parse(Int, rj[1][:count])
end

@memoize shortdoi(doi::AbstractDOI) = fetch_shortdoi(doi).ShortDOI

@memoize function fetch_shortdoi(doi::AbstractDOI)
    fetch_shortdoi(doi.doi)
end

@memoize function fetch_shortdoi(doi::String)
    r = HTTP.get("https://shortdoi.org/$(doi)?format=json")
    return JSON3.read(r.body)
end
"""
    expand(doi::ShortDOI)

Get full DOI from doi.org
"""
@memoize function expand(doi::ShortDOI)
    r = HTTP.get("https://doi.org/api/handles/$(doi.shortdoi)")
    return JSON3.read(r.body)[:values][2][:data][:value]
end


"""
    emph_author(authors, author="", em="b")

Add emphasis to selected author display (e.g. for CV use)
"""
function emph_author(doi::AbstractDOI)
    emph_author(strip(doi.author))
end
function emph_author(doi::EmDOI)
    emph_author(strip(doi.author), doi.highlight)
end
function emph_author(authors, author = "", em = "b")
    orcid = r", \d{4}-\d{4}-\d{4}-\d{4}"
    authors = replace(authors, orcid => "")
    if length(author) > 2
        names = split(author)
        lnfirst = names[end] * ", " * names[1]
        short = names[end] * ", " * names[1][1] * "."
        return replace(
            replace(
                replace(authors, author => "<$em>" * author * "</$em>"),
                short => "<$em>" * short * "</$em>",
            ),
            lnfirst => "<$em>" * lnfirst * "</$em>",
        )
    else
        return authors
    end
end


function strip(s)
    return replace(s, r" \[(.*?)\]" => "")
end
function year(s)
    return !isempty(s) ? parse(Int, first(s, 4)) : "\u0000"
end
