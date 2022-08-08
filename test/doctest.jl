using Documenter, CYTools

DocMeta.setdocmeta!(CYTools, :DocTestSetup, :(using CYTools, Random); recursive = true)

doctest(CYTools)
