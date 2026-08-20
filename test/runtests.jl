using TestItemRunner

@run_package_tests

@testitem "Kroki" begin
    using ShortCodes
    using Test

    @test ShortCodes.kroki("digraph G {Hello->World}") == "https://kroki.io/graphviz/svg/eJxLyUwvSizIUHBXqPZIzcnJ17ULzy_KSakFAGxACMY="
end

@testitem "DOI" begin
    using ShortCodes
    using Test

    julia = DOI("10.1137/141000671")

    @test julia.doi == "10.1137/141000671"
    @test ShortDOI(julia).shortdoi == "10/f9wkpj"
    @test length(split(julia.author,";")) == 4
    @test julia.year == 2017

    emjulia = EmDOI(julia, "Stefan Karpinski")
    @test emjulia.highlight == "Stefan Karpinski"
    @test occursin(
        "<b>Stefan Karpinski</b>",
        ShortCodes.format_authors("Stefan Karpinski;Jeff Bezanson", emjulia.highlight),
    )
    io = IOBuffer()
    show(io, MIME("text/html"), emjulia)
    html = String(take!(io))
    @test startswith(html, "<div>")
    @test occursin("https://doi.org/", html)
end