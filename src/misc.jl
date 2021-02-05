function webpage(url="", height=400, width=700, title="")
    htm = """<iframe src=" """* url * """ " height=" """ * string(height) * """ " width=" """ * string(width) * """ " title=" """ * title * """ "></iframe>"""
    return HTML(htm)
end

function vimeo(video_url)
    url = "https://vimeo.com/api/oembed.json?url=$(HTTP.escapeuri(video_url))&maxheight=500&maxwidth=700&width=680&byline=false&portrait=false&title=false"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
    return HTML(json[:html])
end

function vimeo(video_id::Integer)
    vimeo("https://vimeo.com/$video_id")
end