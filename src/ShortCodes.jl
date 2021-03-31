module ShortCodes

using Base64
using CodecZlib
using FileIO
using HTTP
using ImageIO
using ImageMagick
using Images
using JSON3
using Memoization
using QRCode
using UnicodePlots
using UUIDs

abstract type ShortCode end

include("qr.jl")
include("twitter.jl")
include("youtube.jl")
include("misc.jl")
include("kroki.jl")

export ShortCode

export BlockDiag
export Flickr
export GraphViz
export Mermaid
export PlantUML
export QRC
export Twitter
export Vimeo
export WebPage
export YouTube

end # module
