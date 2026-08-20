# ShortCodes

Simply embed content in a [Pluto](https://github.com/fonsp/Pluto.jl) notebook using short codes, inspired by the [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/). `ShortCodes` should also work in other environments such as Jupyter, Olive.jl, Documenter.jl, Franklin and maybe more, as they all support rich display of types, but I have not tested this.

The basic usage is shown below, check out the [example](https://raw.githack.com/hellemo/ShortCodes.jl/main/examples/static-demo.html) to get an impression of the resulting page.

## Usage

```julia
using ShortCodes

# Embed Bluesky post by url
Bluesky("https://bsky.app/profile/jbytecode.bsky.social/post/3m2pe3qcxjc27")

# Embed youtube video by id and seek to start 
# time and pause to show custom still image
YouTube("IAF8DjrQSSk", 2, 30) # 2 min 30 sec

# Embed youtube video showing only default thumbnail
# based on lite-youtube-embeds
YouTubeLite("IAF8DjrQSSk")

# Embed Flickr image by id (or by url)
Flickr(29110717138)

# Show DOI info from OpenCitations (the default backend)
DOI("10.1137/141000671")

# Use OpenAlex for richer work metadata and OpenAlex citation counts
DOI("10.1137/141000671"; backend = :openalex)

The OpenAlex backend currently provides the same rendered DOI fields as the
OpenCitations backend, including authors, title, venue, publication date,
volume, issue, pages, and citation count. OpenCitations remains the default;
backend failures are not silently replaced by another backend.

# Embed a web page:
WebPage("https://julialang.org/downloads/#current_stable_release")

# Show QR code for text (QRCoders extension)
using QRCoders
QRC(raw"https://docs.julialang.org/en/v1/")
```

## Note

* YouTube shows an overlay when the video is paused, promoting "more videos", and the API does not allow hiding it. A workaround is to [block the overlay using uBlock](https://www.reddit.com/r/firefox/comments/61y7lf/how_to_removedisable_more_videos_when_pausing_an/).
* Some browsers may block content from social media, e.g. Firefox may block Twitter embeds, check the settings of your browser if it doesn't load.
