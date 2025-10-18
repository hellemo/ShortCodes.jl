module ShortCodes

using Base64
using CodecZlib
using Downloads
using URIs
using JSON
using Memoize
using UUIDs

abstract type ShortCode end

function http_get(url; kwargs...)
    io = IOBuffer()
    Downloads.request(url; output = io, kwargs...)
    read(seekstart(io))
end

include("extension_types.jl")
include("doi.jl")
include("twitter.jl")
include("youtube.jl")
include("misc.jl")
include("kroki.jl")

export ShortCode

export BlockDiag
export DOI, EmDOI, ShortDOI
export Flickr
export GraphViz
export Mermaid
export PlantUML
export Twitter
export Vimeo
export WebPage
export YouTube
export QRC

end # module
