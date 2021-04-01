using ShortCodes
using Test





@testset "Kroki tests" begin
    
    @test ShortCodes.kroki("digraph G {Hello->World}") == "https://kroki.io/graphviz/svg/eJxLyUwvSizIUHBXqPZIzcnJ17ULzy_KSakFAGxACMY="

end