push!(LOAD_PATH,"../src/")
using Documenter, CYTools, DocumenterMarkdown

# ensure CYTools is loaded for the doc tests
DocMeta.setdocmeta!(CYTools, :DocTestSetup, :(using CYTools, Random); recursive = true)

makedocs(sitename="CYTools")

deploydocs(repo = "https://github.com/HereAround/CYTools.jl.git")
