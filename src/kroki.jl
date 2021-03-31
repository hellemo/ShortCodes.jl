abstract type Kroki <: ShortCode end

function Base.show(io::IO, ::MIME"text/plain", kroki::Kroki)
    print(io, kroki.text * "\n" * kroki(kroki.text, lowercase(String(nameof(typeof(kroki)))), "svg"))
end

function Base.show(io::IO, ::MIME"image/svg+xml", kroki::Kroki)
    write(io, fetch_kroki(kroki.text, lowercase(String(nameof(typeof(kroki)))), "svg"))
end

struct GraphViz <: Kroki
    text::String
end

struct Mermaid <: Kroki
    text::String
end

struct PlantUML <: Kroki
    text::String
end

struct BlockDiag <: Kroki
    text::String
end

function kroki(krokitext, generator="graphviz", format="svg")
    encoded = base64urlencode(compress(krokitext))
    url = "https://kroki.io/$generator/$format/$encoded"
end

@memoize function fetch_kroki(krokitext, generator="graphviz", format="svg")
    response = HTTP.get(kroki(krokitext, generator, format))
    String(response.body)
end

function base64urlencode(text)
    str = base64encode(text)
    return replace(replace(str, "/"=>"_"),"+"=>"-")
end

function compress(text)
    return transcode(ZlibCompressor, text)
end