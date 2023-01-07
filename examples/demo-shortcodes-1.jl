### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# ╔═╡ a7288f0e-92c2-11eb-1f09-55b1249cddfc
using ShortCodes

# ╔═╡ b4638c6e-92c2-11eb-3455-297ca53dbf37
md" # ShortCodes

Simple embedding for [Pluto notebooks](https://github.com/fonsp/Pluto.jl)
"

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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"

[compat]
ShortCodes = "~0.3.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "60ed5f1643927479f845b0135bb369b031b541fa"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.14"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON3]]
deps = ["Dates", "Mmap", "Parsers", "StructTypes", "UUIDs"]
git-tree-sha1 = "b3e5984da3c6c95bcf6931760387ff2e64f508f3"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.9.1"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "5a5bc6bf062f0f95e62d0fe0a2d99699fed82dd9"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.8"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "9d8c00ef7a8d110787ff6f170579846f776133a9"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.4"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[ShortCodes]]
deps = ["Base64", "CodecZlib", "HTTP", "JSON3", "Memoize", "UUIDs"]
git-tree-sha1 = "866962b3cc79ad3fee73f67408c649498bad1ac0"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.3.2"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "8445bf99a36d703a09c601f9a57e2f83000ef2ae"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.7.3"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"
"""

# ╔═╡ Cell order:
# ╠═a7288f0e-92c2-11eb-1f09-55b1249cddfc
# ╟─b4638c6e-92c2-11eb-3455-297ca53dbf37
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
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
