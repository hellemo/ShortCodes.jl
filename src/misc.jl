struct WebPage <: ShortCode
    url::String
end

function Base.show(io::IO, ::MIME"text/plain", page::WebPage)
    print(io, page.url)
end

function Base.show(io::IO, ::MIME"text/html", page::WebPage)
    print(io, webpage(page.url))
end

function webpage(url="", height=400, width=700, title="")
    htm = """<iframe src=" """* url * """ " height=" """ * string(height) * """ " width=" """ * string(width) * """ " title=" """ * title * """ "></iframe>"""
    return htm
end


struct Vimeo <: ShortCode
    id::Integer
end

function Base.show(io::IO, ::MIME"text/plain", video::Vimeo)
    print(io, "https://vimeo.com/$(video.id)")
end

function Base.show(io::IO, ::MIME"text/html", video::Vimeo)
    write(io, vimeo(video.id))
end

@memoize function vimeo(video_url)
    url = "https://vimeo.com/api/oembed.json?url=$(HTTP.escapeuri(video_url))&maxheight=500&maxwidth=700&width=680&byline=false&portrait=false&title=false"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
    return json[:html]
end

function vimeo(video_id::Integer)
    vimeo("https://vimeo.com/$video_id")
end