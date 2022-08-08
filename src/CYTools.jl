module CYTools

# use other Julia packages
using Markdown
using Pkg
using Oscar

"""
Initializing function for 'CYTools'.
"""
# initialization
function __init__()
    print("Welcome to CYTools ")
    printstyled("$version\n", color = :green)
    println("Enjoy this software to perform computations on Calabi-Yau hypersurfaces in normal toric varieties!")
end

const PROJECT_TOML = Pkg.TOML.parsefile(joinpath(@__DIR__, "..", "Project.toml"))
const VERSION_NUMBER = VersionNumber(PROJECT_TOML["version"])
const IS_DEV = isdir(@__DIR__, "..", ".git")

"""
    version

The version number of the loaded `CYTools`.
Please mention this number in any bug report.
"""
const version = IS_DEV ? VersionNumber("$(VERSION_NUMBER)-dev") : VERSION_NUMBER

# include files
#include("CYHypersurfaces/constructors.jl")

end
