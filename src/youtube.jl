function youtube(id, seekto)
    htm = """
   <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>
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
        player = new YT.Player('player', {
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
        return HTML(htm)
end


function youtube(id)
    url = "https://youtube.com/oembed?url=http://www.youtube.com/watch?v=$id&format=json&maxwidth=600&maxheight=500"
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
