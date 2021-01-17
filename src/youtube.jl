function youtube(id)
    url = "https://youtube.com/oembed?url=http://www.youtube.com/watch?v=$id&format=json&maxwidth=800"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
    return HTML(json[:html])
end

function flickr(flickr_url)
    url = "http://www.flickr.com/services/oembed/?format=json&url=$flickr_url"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
    return HTML(json[:html])
end
