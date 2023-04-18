

struct YouTube <: ShortCode
    id::String
    seekto::Int32
end

function Base.show(io::IO, ::MIME"text/plain", video::YouTube)
    video_as_text = "https://www.youtube.com/watch?v=$(video.id)&start=$(video.seekto)"
    print(io, video_as_text)
end

function Base.show(io::IO, ::MIME"text/html", video::YouTube)
    print(io, youtube(video.id, video.seekto))
end

YouTube(id, seektomin, seektosec) = YouTube(id, seektomin * 60 + seektosec)
YouTube(id) = YouTube(id, 0)
"""
    Embed youtube video id that seeks seekto seconds into the video and pauses there to 
    make it possible to show a particular still from the video by default.
"""
@memoize function youtube(id, seekto)
    """
	<script src="https://cdn.jsdelivr.net/npm/lite-youtube-embed@0.2.0/src/lite-yt-embed.js" integrity="sha256-wwYlfEzWnCf2nFlIQptfFKdUmBeH5d3G7C2352FdpWE=" crossorigin="anonymous" defer></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lite-youtube-embed@0.2.0/src/lite-yt-embed.css" integrity="sha256-99PgDZnzzjO63EyMRZfwIIA+i+OS2wDx6k+9Eo7JDKo=" crossorigin="anonymous">

	<lite-youtube videoid=$(id) params="modestbranding=1&rel=0&start=$(string(seekto))"></lite-youtube>
	"""
end

"""
    Embed youtube video by id, seek to seektomin minutes and seektosek second in
"""
function youtube(id, seektomin, seektosec)
    youtube(id, seektomin * 60 + seektosec)
end


"""
    Embed youtube video by id, uses default oembed code with reasonable size.
"""
function youtube(id)
    youtube(id, 0)
end


struct Flickr <: ShortCode
    id::Integer
end

Flickr(url::String) = Flickr(parse(Int, split(url, "/")[6])) # This should be more robust

function Base.show(io::IO, ::MIME"text/plain", img::Flickr)
    json = fetch_flickr(img.id)
    flickr_as_text = "$(json[:author_name]): $(json[:title])\n$(json[:web_page])"
    print(io, flickr_as_text)
end

function Base.show(io::IO, ::MIME"text/html", img::Flickr)
    json = fetch_flickr(img.id)
    print(io, json[:html])
end

@memoize function fetch_flickr(id)
    url = "https://www.flickr.com/services/oembed/?format=json&url=http%3A//www.flickr.com/photos/bees/$id"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
end
