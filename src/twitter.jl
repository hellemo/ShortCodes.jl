function twitter(id)
    json = fetch_twitter(id)
    return json[:html]
end

@memoize function fetch_twitter(id)
    url = "https://publish.twitter.com/oembed?url=https://twitter.com/andypiper/status/$id"
    json = JSON3.read(http_get(url))
end

struct Twitter <: ShortCode
    id::Int64
end

function Base.show(io::IO, ::MIME"text/plain", tweet::Twitter)
    json = fetch_twitter(tweet.id)
    tweet_as_text = "$(json[:author_name]): $(json[:url])"
    print(io, tweet_as_text)
end

function Base.show(io::IO, ::MIME"text/html", tweet::Twitter)
    print(io, twitter(tweet.id))
end

struct Bluesky <: ShortCode
    full_url::AbstractString
end

@memoize function fetch_bluesky(full_url)
    url = "https://embed.bsky.app/oembed/?url=$full_url"
    try
        json = JSON3.read(String(http_get(url)))
        return json[:html]
    catch err
        contains(err.msg, "post not found") && return "<em>Post not found</em>"
        contains(err.msg, "post is not public") && return "<em>Post is not public</em>"
        return "<em>$(err.msg)</em>"
    end
end

function Base.show(io::IO, ::MIME"text/html", tweet::Bluesky)
    print(io, fetch_bluesky(tweet.full_url))
end

function Base.show(io::IO, ::MIME"text/plain", tweet::Bluesky)
    json = fetch_bluesky(tweet.full_url)
    print(io, json)
end