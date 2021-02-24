function twitter(id)
    json = fetch_twitter(id)
    return json[:html]
end

@memoize function fetch_twitter(id)
    url = "https://publish.twitter.com/oembed?url=https://twitter.com/andypiper/status/$id"
    response = HTTP.get(url)
    json = JSON3.read(String(response.body))
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