### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ a7288f0e-92c2-11eb-1f09-55b1249cddfc
using ShortCodes

# ╔═╡ b4638c6e-92c2-11eb-3455-297ca53dbf37
md" # ShortCodes

Simple embedding for [Pluto notebooks](https://github.com/fonsp/Pluto.jl)
"

# ╔═╡ 9b254100-8daf-4ca8-9c8c-9423ccc8c162
md"# Bluesky"

# ╔═╡ b2a36af0-6874-48a1-a0db-8c4b325c0a80
Bluesky("https://bsky.app/profile/jbytecode.bsky.social/post/3m2pe3qcxjc27")

# ╔═╡ bf967628-92c2-11eb-0794-654da6ac5292
md"# Twitter"

# ╔═╡ c4650640-92c2-11eb-2a5b-ed1dc13273ac
Twitter(1314967811626872842)

# ╔═╡ c90a21b6-92c2-11eb-0020-cf0095378602
md"# YouTube
Embed a video and seek to the given point in the video."

# ╔═╡ d5e1705e-92c2-11eb-2369-cba030f80467
YouTube("IAF8DjrQSSk",18,27)

# ╔═╡ db03ba94-92c2-11eb-0d9e-9382dc14f783
md"# Flickr"

# ╔═╡ e02ef00c-92c2-11eb-0036-e9f6a7a34ddc
Flickr(29110717138)

# ╔═╡ e7c836f4-92c2-11eb-3f84-77ffa870187e
md"# Embed Web Page"

# ╔═╡ e9db6308-92c2-11eb-0dda-09b6a1e6bb7e
WebPage("https://julialang.org/downloads/#current_stable_release")

# ╔═╡ f2f0fdd6-92c2-11eb-2e52-c5ea0f9288fc
md"# Vimeo"

# ╔═╡ feb4b4e6-92c2-11eb-0fe8-895a5ee0b084
Vimeo(171764413)

# ╔═╡ 96e66150-c4bb-4c77-b752-d04f8d366bca
md"# DOI
DOI information via [opencitations.net](https://opencitations.net) and [doi.org](https://doi.org)"

# ╔═╡ 8079cb71-95d7-4849-b5a4-abbb43f038f8
DOI("10.1137/141000671")

# ╔═╡ 1cda6524-92c3-11eb-145d-333251ab7498
md"# GraphViz"

# ╔═╡ 23e1b908-92c3-11eb-07c7-79c227f37cd8
GraphViz("digraph G {Hello->World}")

# ╔═╡ f001ad0c-92c3-11eb-15dd-0b6029eba08c
md"# Mermaid"

# ╔═╡ faa2b3f2-92c3-11eb-36a2-b716c6113df4
Mermaid("gantt
section Section
Completed :done,    des1, 2014-01-06,2014-01-08
Active        :active,  des2, 2014-01-07, 3d
Parallel 1   :         des3, after des1, 1d
Parallel 2   :         des4, after des1, 1d
Parallel 3   :         des5, after des3, 1d
Parallel 4   :         des6, after des4, 1d")

# ╔═╡ 05880a9e-92c4-11eb-1ca6-25556245f92d
md"# BlockDiag"

# ╔═╡ 0c92c8ea-92c4-11eb-08cd-f9e7d4cbdf24
BlockDiag("""blockdiag {
  Kroki -> generates -> "Block diagrams";
  Kroki -> is -> "very easy!";

  Kroki [color = "greenyellow"];
  "Block diagrams" [color = "pink"];
  "very easy!" [color = "orange"];
}""")

# ╔═╡ d4dd1922-92c4-11eb-3dff-a71dd1f96782
md"# PlantUML"

# ╔═╡ dcbec424-92c4-11eb-2ce6-d3ac255b3099
PlantUML("@startmindmap
skinparam monochrome true
+ OS
++ Ubuntu
+++ Linux Mint
+++ Kubuntu
+++ Lubuntu
+++ KDE Neon
++ LMDE
++ SolydXK
++ SteamOS
++ Raspbian
-- Windows 95
-- Windows 98
-- Windows NT
--- Windows 8
--- Windows 10
@endmindmap")

# ╔═╡ 914c09ce-a05c-461d-861a-2f7200947959
md"# DOIs"

# ╔═╡ 131b2b98-47af-425b-87b0-24e02d5ef61f
DOI("10.1137/141000671")

# ╔═╡ ad0606a2-9964-4826-9697-01addbf05007
EmDOI("10.1137/141000671", "Shah")

# ╔═╡ f19c0797-3914-418e-9e6f-dde98cb0fe15
md"## Customize DOI display"

# ╔═╡ e7c8b30e-2c93-4250-8782-8c99a16cb828
begin
	ShortCodes._use_citations(::DOI) = false
	ShortCodes._use_short_doi(::DOI) = false
	ShortCodes._use_N_authors() = 3
end

# ╔═╡ 2b2eb594-8f68-4dbd-8756-3a68cf8b21ad
DOI("10.1137/141000671")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"

[compat]
ShortCodes = "~0.4.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "06ea418d0c95878c8f3031023951edcf25b9e0ef"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.2.0"

    [JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]

    [JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.11.1+1"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[ShortCodes]]
deps = ["Base64", "CodecZlib", "Downloads", "JSON", "LinearAlgebra", "Memoize", "URIs", "UUIDs"]
git-tree-sha1 = "f597fa3f0b71ec0eed6678b5a285747ad10349cc"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.4.0"

    [ShortCodes.extensions]
    QRCodersExt = "QRCoders"

    [ShortCodes.weakdeps]
    QRCoders = "f42e9828-16f3-11ed-2883-9126170b272d"

[[StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "cd47aa083c9c7bdeb7b92de26deb46d6a33163c9"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.5.1"

    [StructUtils.extensions]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsTablesExt = ["Tables"]

    [StructUtils.weakdeps]
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"
"""

# ╔═╡ Cell order:
# ╠═a7288f0e-92c2-11eb-1f09-55b1249cddfc
# ╟─b4638c6e-92c2-11eb-3455-297ca53dbf37
# ╟─9b254100-8daf-4ca8-9c8c-9423ccc8c162
# ╠═b2a36af0-6874-48a1-a0db-8c4b325c0a80
# ╟─bf967628-92c2-11eb-0794-654da6ac5292
# ╠═c4650640-92c2-11eb-2a5b-ed1dc13273ac
# ╠═c90a21b6-92c2-11eb-0020-cf0095378602
# ╠═d5e1705e-92c2-11eb-2369-cba030f80467
# ╟─db03ba94-92c2-11eb-0d9e-9382dc14f783
# ╠═e02ef00c-92c2-11eb-0036-e9f6a7a34ddc
# ╟─e7c836f4-92c2-11eb-3f84-77ffa870187e
# ╠═e9db6308-92c2-11eb-0dda-09b6a1e6bb7e
# ╟─f2f0fdd6-92c2-11eb-2e52-c5ea0f9288fc
# ╠═feb4b4e6-92c2-11eb-0fe8-895a5ee0b084
# ╟─96e66150-c4bb-4c77-b752-d04f8d366bca
# ╠═8079cb71-95d7-4849-b5a4-abbb43f038f8
# ╟─1cda6524-92c3-11eb-145d-333251ab7498
# ╠═23e1b908-92c3-11eb-07c7-79c227f37cd8
# ╟─f001ad0c-92c3-11eb-15dd-0b6029eba08c
# ╠═faa2b3f2-92c3-11eb-36a2-b716c6113df4
# ╟─05880a9e-92c4-11eb-1ca6-25556245f92d
# ╠═0c92c8ea-92c4-11eb-08cd-f9e7d4cbdf24
# ╟─d4dd1922-92c4-11eb-3dff-a71dd1f96782
# ╠═dcbec424-92c4-11eb-2ce6-d3ac255b3099
# ╟─914c09ce-a05c-461d-861a-2f7200947959
# ╠═131b2b98-47af-425b-87b0-24e02d5ef61f
# ╠═ad0606a2-9964-4826-9697-01addbf05007
# ╟─f19c0797-3914-418e-9e6f-dde98cb0fe15
# ╠═e7c8b30e-2c93-4250-8782-8c99a16cb828
# ╠═2b2eb594-8f68-4dbd-8756-3a68cf8b21ad
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
