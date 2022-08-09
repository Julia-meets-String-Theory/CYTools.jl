using Pkg
Pkg.add("Oscar")
using Oscar
using Documenter
using CYTools

DocMeta.setdocmeta!(CYTools, :DocTestSetup, :(using CYTools, Random; using Oscar); recursive = true)

doctest(CYTools)
