struct GraphViz <: ShortCode
    text::String
end

function Base.show(io::IO, ::MIME"text/plain", graphviz::GraphViz)
    print(io, graphviz.text * "\n" * kroki(graphviz.text, "graphviz", "svg"))
end

function Base.show(io::IO, ::MIME"image/svg+xml", graphviz::GraphViz)
    write(io, fetch_kroki(graphviz.text, "graphviz", "svg"))
end

struct Mermaid <: ShortCode
    text::String
end

function Base.show(io::IO, ::MIME"text/plain", mermaid::Mermaid)
    print(io, mermaid.text * "\n" * kroki(mermaid.text, "mermaid", "svg"))
end

function Base.show(io::IO, ::MIME"image/svg+xml", mermaid::Mermaid)
    write(io, fetch_kroki(mermaid.text, "mermaid", "svg"))
end

struct PlantUML <: ShortCode
    text::String
end

function Base.show(io::IO, ::MIME"text/plain", plant::PlantUML)
    print(io, plant.text * "\n" * kroki(plant.text, "plantuml", "svg"))
end

function Base.show(io::IO, ::MIME"image/svg+xml", plant::PlantUML)
    write(io, fetch_kroki(plant.text, "plantuml", "svg"))
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