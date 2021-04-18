# ShortCodes

Simply embed content in a [Pluto](https://github.com/fonsp/Pluto.jl) notebook using short codes, inspired by the [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/).

The basic usage is shown below, check out the [example](https://htmlpreview.github.io/?https://github.com/hellemo/ShortCodes.jl/blob/main/examples/static-demo.html) to get an impression of the resulting page.

## Usage

```julia
using ShortCodes

# Embed tweet by id
Twitter(1314967811626872842)

# Embed youtube video by id and seek to start 
# time and pause to show custom still image
YouTube("IAF8DjrQSSk", 2, 30) # 2 min 30 sec

# Embed Flickr image by id (or by url)
Flickr(29110717138)

# Show DOI info from opencitations.net
DOI("10.1137/141000671")
```

## Note

* YouTube shows an overlay when the video is paused, promoting "more videos", and the API does not allow hiding it. A workaround is to [block the overlay using uBlock](https://www.reddit.com/r/firefox/comments/61y7lf/how_to_removedisable_more_videos_when_pausing_an/).
* Some browsers may block content from social media, e.g. Firefox may block Twitter embeds, check the settings of your browser if it doesn't load.