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
    make it possible to show a particular still from the video by default. Note that 
    the youtube API disallows hiding the annoying "More videos" overlay. 
"""
@memoize function youtube(id, seekto)
    vid = string(uuid1()) # Assign each video unique id to allow multiple instances.
    htm =
        """
  <div id=" """ *
        vid *
        """ "></div>
<script>
// 2. This code loads the IFrame Player API code asynchronously.
  var tag = document.createElement('script');

  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // 3. This function creates an <iframe> (and YouTube player)
  //    after the API code downloads.
  var player;
  function onYouTubeIframeAPIReady() {
    player = new YT.Player(' """ *
        vid *
        """ ', {
          height: '390',
          width: '640',
		  rel: '0',
		  showinfo: '0',
iv_load_policy: '3',
showinfo: '0',
          videoId: '""" *
        id *
        """',
  //modestbranding: 1,
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      });
      
    }

    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
event.target.mute();
event.target.seekTo(""" *
        string(seekto) *
        """);
        event.target.playVideo();
      }

      // 5. The API calls this function when the player's state changes.
      //    The function indicates that when playing a video (state=1),
      //    the player should play for six seconds and then stop.
      var done = false;
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING && !done) {
          setTimeout(stopVideo, 0);
          done = true;
        }
      }
      function stopVideo() {
        player.pauseVideo();
      }
      
      // Check if YT is loaded before trying to start player
      function pollYT () {
        if (typeof(YT) == 'undefined') {
            setTimeout(pollYT, 300); // try again in 300 milliseconds
        } else {
            onYouTubeIframeAPIReady();
        }
      }

      pollYT();
    </script>
"""
    return htm
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
    url = "https://youtube.com/oembed?url=http://www.youtube.com/watch?v=$id&format=json&maxwidth=600&maxheight=500"
    json = JSON.parse(http_get(url))
    return HTML(json.html)
end

struct Flickr <: ShortCode
    id::Integer
end

Flickr(url::String) = Flickr(parse(Int, split(url, "/")[6])) # This should be more robust

function Base.show(io::IO, ::MIME"text/plain", img::Flickr)
    json = fetch_flickr(img.id)
    flickr_as_text = "$(json.author_name): $(json.title)\n$(json.web_page)"
    print(io, flickr_as_text)
end

function Base.show(io::IO, ::MIME"text/html", img::Flickr)
    json = fetch_flickr(img.id)
    print(io, json.html)
end

@memoize function fetch_flickr(id)
    url = "https://www.flickr.com/services/oembed/?format=json&url=http%3A//www.flickr.com/photos/bees/$id"
    json = JSON.parse(http_get(url))
end


struct LiteYouTube <: ShortCode
    id::String
    seekto::Int32
end

function Base.show(io::IO, ::MIME"text/plain", video::LiteYouTube)
    video_as_text = "https://www.youtube.com/watch?v=$(video.id)&start=$(video.seekto)"
    print(io, video_as_text)
end

function Base.show(io::IO, ::MIME"text/html", video::LiteYouTube)
    print(io, liteyoutube(video.id, video.seekto))
end


LiteYouTube(id) = LiteYouTube(id, 0)
"""
 Embed youtube video id that seeks seekto seconds into the video and pauses there to 
    make it possible to show a particular still from the video by default.
"""
@memoize function liteyoutube(id, seekto)
    """<script src="https://cdn.jsdelivr.net/npm/lite-youtube-embed@0.2.0/src/lite-yt-embed.js" integrity="sha256-wwYlfEzWnCf2nFlIQptfFKdUmBeH5d3G7C2352FdpWE=" crossorigin="anonymous" defer></script>
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lite-youtube-embed@0.2.0/src/lite-yt-embed.css" integrity="sha256-99PgDZnzzjO63EyMRZfwIIA+i+OS2wDx6k+9Eo7JDKo=" crossorigin="anonymous">
    	<lite-youtube videoid=$(id) params="modestbranding=1&rel=0&start=$(string(seekto))"></lite-youtube>
    """
end
