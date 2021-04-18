using ShortCodes
using Test

@testset "Kroki tests" begin
    @test ShortCodes.kroki("digraph G {Hello->World}") == "https://kroki.io/graphviz/svg/eJxLyUwvSizIUHBXqPZIzcnJ17ULzy_KSakFAGxACMY="
end

@testset "DOI tests"  begin
    julia = DOI("10.1137/141000671")
    
    @test julia.doi == "10.1137/141000671"
    @test ShortDOI(julia).shortdoi == "10/f9wkpj"
    @test length(split(julia.author,";")) == 4
    @test julia.year == 2017
   
    emjulia = EmDOI(julia, "Stefan Karpinski")
    @test emjulia.highlight == "Stefan Karpinski" 
    io = IOBuffer()
    show(io, MIME("text/html"), emjulia)
    @test findfirst("<b>", String(take!(io)) ) == 37:39
end