module ShortCodes

using HTTP
using ImageIO
using ImageMagick
using Images
using JSON3
using QRCode
using UUIDs

include("qr.jl")
include("twitter.jl")
include("youtube.jl")

end # module
