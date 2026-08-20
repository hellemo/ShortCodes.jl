using ShortCodes
using Test

@testset "Kroki tests" begin
    @test ShortCodes.kroki("digraph G {Hello->World}") == "https://kroki.io/graphviz/svg/eJxLyUwvSizIUHBXqPZIzcnJ17ULzy_KSakFAGxACMY="
end

@testset "DOI tests" begin
    julia = DOI("10.1137/141000671")

    @test julia.doi == "10.1137/141000671"
    @test ShortDOI(julia).shortdoi == "10/f9wkpj"
    @test length(split(julia.author, ";")) == 4
    @test julia.year == 2017

    emjulia = EmDOI(julia, "Karpinski")
    @test emjulia.highlight == "Karpinski"
    io = IOBuffer()
    show(io, MIME("text/html"), emjulia)
    @test occursin("<b> Karpinski, Stefan</b>", String(take!(io)))
    @test ShortCodes.format_authors("Ada Lovelace;Grace Hopper") == "Ada Lovelace and Grace Hopper"
    @test ShortCodes.format_authors("Ada Lovelace;Grace Hopper;Katherine Johnson") ==
          "Ada Lovelace, Grace Hopper and Katherine Johnson"
    @test ShortCodes.format_authors("") == ""
    @test ShortCodes.format_authors("Ada Lovelace; Grace Hopper") == "Ada Lovelace and Grace Hopper"
end

@testset "DOI backend tests" begin
    doi = DOI("10.1137/141000671")
    openalex_doi = DOI("10.1137/141000671"; backend=:openalex)

    @test doi.backend == :opencitations
    @test openalex_doi.backend == :openalex
    @test_throws ArgumentError DOI("10.1137/141000671"; backend=:unknown)
    @test ShortCodes.openalex_url("10.1137/141000671") ==
          "https://api.openalex.org/works/https://doi.org/10.1137/141000671"

    work = Dict(
        "id" => "https://openalex.org/W123",
        "title" => "An OpenAlex work",
        "publication_year" => 2024,
        "publication_date" => "2024-05-17",
        "type" => "article",
        "authorships" => [
            Dict("author" => Dict("display_name" => "Ada Lovelace")),
            Dict("author" => Dict("display_name" => "Grace Hopper")),
        ],
        "primary_location" => Dict(
            "source" => Dict(
                "display_name" => "Example Journal",
                "host_organization_name" => "Example Publisher",
            ),
        ),
        "biblio" => Dict(
            "volume" => "12",
            "issue" => "3",
            "first_page" => "10",
            "last_page" => "20",
        ),
    )
    metadata = ShortCodes.normalize_openalex_metadata(work, "10.1137/141000671")

    @test metadata["title"] == "An OpenAlex work"
    @test metadata["author"] == "Ada Lovelace;Grace Hopper"
    @test metadata["pub_date"] == "2024-05-17"
    @test metadata["venue"] == "Example Journal"
    @test metadata["page"] == "10-20"
    @test metadata["volume"] == "12"
    @test metadata["issue"] == "3"
    @test ShortCodes.parse_int_or_empty("") == ""
    @test ShortCodes.parse_int_or_empty("12") == 12
end