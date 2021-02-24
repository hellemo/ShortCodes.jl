module ShortCodes

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

export ShortCode

export Flickr
export QRC
export Twitter
export Vimeo
export WebPage
export YouTube

end # module
