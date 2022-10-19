push!(LOAD_PATH,"../src/")
using Documenter, CYTools, DocumenterMarkdown, Oscar

# ensure CYTools is loaded for the doc tests
DocMeta.setdocmeta!(CYTools, :DocTestSetup, :(using CYTools, Random; using CYTools.Oscar;); recursive = true)

makedocs(
    format = Documenter.HTML(),
    sitename = "CYTools",
    modules = [CYTools],
    clean = true,
    doctest = false,
    pages = ["index.md",
            "CYTools/Introduction.md",
            "Functionality" => ["CYTools/CYHypersurfaces.md",
                                "CYTools/Utilities.md" ],
            ]
    )

deploydocs(repo = "github.com/HereAround/CYTools.jl.git")
