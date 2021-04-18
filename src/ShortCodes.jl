module ShortCodes

using Base64
using CodecZlib
using HTTP
using JSON3
using Memoize
using UUIDs

abstract type ShortCode end

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

end # module
