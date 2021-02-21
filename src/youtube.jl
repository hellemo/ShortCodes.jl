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

YouTube(id, seektomin, seektosec) = YouTube(id, seektomin*60 + seektosec)

"""
    Embed youtube video id that seeks seekto seconds into the video and pauses there to 
    make it possible to show a particular still from the video by default. Note that 
    the youtube API disallows hiding the annoying "More videos" overlay. 
"""
function youtube(id, seekto)
    vid = string(uuid1()) # Assign each video unique id to allow multiple instances.
    htm = """
   <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id=" """ * vid * """ "></div>
	<script src="https://www.youtube.com/iframe_api"></script>
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
        player = new YT.Player(' """ * vid * """ ', {
          height: '390',
          width: '640',
		  rel: '0',
		  showinfo: '0',
iv_load_policy: '3',
showinfo: '0',
          videoId: '""" * id * """',
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
		event.target.seekTo(""" * string(seekto) * """);
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
        player.pauseVideo()
		//player.stopVideo();
      }
	onYouTubeIframeAPIReady()
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
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
    return HTML(json[:html])
end

struct Flickr <: ShortCode
    url::String
end

function Base.show(io::IO, ::MIME"text/plain", img::Flickr)
    print(io, img.url)
end

function Base.show(io::IO, ::MIME"text/html", img::Flickr)
    print(io, flickr(img.url))
end

function flickr(flickr_url)
    url = "http://www.flickr.com/services/oembed/?format=json&url=$flickr_url"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
    return json[:html]
end
