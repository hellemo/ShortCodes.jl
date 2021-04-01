### A Pluto.jl notebook ###
# v0.12.21

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
Embed a video and seek to the given point in the video (not shown in the static version)."

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

# ╔═╡ Cell order:
# ╠═a7288f0e-92c2-11eb-1f09-55b1249cddfc
# ╟─b4638c6e-92c2-11eb-3455-297ca53dbf37
# ╟─bf967628-92c2-11eb-0794-654da6ac5292
# ╠═c4650640-92c2-11eb-2a5b-ed1dc13273ac
# ╟─c90a21b6-92c2-11eb-0020-cf0095378602
# ╠═d5e1705e-92c2-11eb-2369-cba030f80467
# ╟─db03ba94-92c2-11eb-0d9e-9382dc14f783
# ╠═e02ef00c-92c2-11eb-0036-e9f6a7a34ddc
# ╟─e7c836f4-92c2-11eb-3f84-77ffa870187e
# ╠═e9db6308-92c2-11eb-0dda-09b6a1e6bb7e
# ╟─f2f0fdd6-92c2-11eb-2e52-c5ea0f9288fc
# ╠═feb4b4e6-92c2-11eb-0fe8-895a5ee0b084
# ╟─1cda6524-92c3-11eb-145d-333251ab7498
# ╠═23e1b908-92c3-11eb-07c7-79c227f37cd8
# ╟─f001ad0c-92c3-11eb-15dd-0b6029eba08c
# ╠═faa2b3f2-92c3-11eb-36a2-b716c6113df4
# ╟─05880a9e-92c4-11eb-1ca6-25556245f92d
# ╠═0c92c8ea-92c4-11eb-08cd-f9e7d4cbdf24
# ╟─d4dd1922-92c4-11eb-3dff-a71dd1f96782
# ╠═dcbec424-92c4-11eb-2ce6-d3ac255b3099
