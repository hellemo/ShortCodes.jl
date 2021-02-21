# ShortCodes

Simple functions to easily embed content in a [Pluto](https://github.com/fonsp/Pluto.jl) notebook using short function calls, inspired by the [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/).

The basic usage is shown below, check out the [examples](https://htmlpreview.github.io/?https://github.com/hellemo/ShortCodes.jl/blob/main/examples/static-demo.html) to get an impression of the resulting page.

## Usage

```julia
using ShortCodes

# Embed tweet by id
ShortCodes.twitter(1314967811626872842)

# Embed youtube video by id
ShortCodes.youtube("IAF8DjrQSSk")

# Embed Flickr image by url
ShortCodes.flickr("https://www.flickr.com/photos/153311384@N03/29110717138")

# Share string, e.g. a url with the audience of a presentation using QR code:
ShortCodes.qr("https://julialang.org/downloads/#current_stable_release")
```
