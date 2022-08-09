# CYTools.jl

## Goal

The package CYTools.jl aims towards making the *entire* functionality of the Python package [CYTools](https://cytools.liammcallistergroup.com/about/) available in Julia. We base this project on [OSCAR](https://oscar.computeralgebra.de/) for general functionality on toric spaces, polyhedral geometry etc. Specialized algorithms (for CICYs, 3 and 4-dimensional reflexive polytopes in the Kreuzer-Skarke list) will be collected in this Julia package.

As long as infrastructure/architecture is concerned, the goal is to write code which would eventually allow for a full-scale integration into [OSCAR](https://oscar.computeralgebra.de/). Such an integration would have to be discussed in more detail once the time comes.

On the long run, a key step towards writing this package is to re-write core algorithm of the existing [CYTools](https://cytools.liammcallistergroup.com/about/) in a small and self-contained C++ project. Upon wrapping this code, this functionality can then be made available in Julia (but also in other languages, such as Python or other large software projects ([Macaulay2](http://www2.macaulay2.com/Macaulay2/), [Sage](https://www.sagemath.org/),...) or commercial software such as Mathematica). This approach has the added advantage that large libraries (e.g. [CGAL](https://www.cgal.org/)) need not be included. So this package should be slim and easily to install.


## Code coverage and tests

* [![CI](https://github.com/HereAround/CYTools.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/HereAround/CYTools.jl/actions/workflows/CI.yml)
* [![pages-build-deployment](https://github.com/HereAround/CYTools.jl/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/HereAround/CYTools.jl/actions/workflows/pages/pages-build-deployment)
* [![codecov](https://codecov.io/gh/HereAround/CYTools.jl/branch/master/graph/badge.svg?token=RX0SNJAVQZ)](https://codecov.io/gh/HereAround/CYTools.jl)
* [Sunburst](https://codecov.io/gh/HereAround/CYTools.jl/branch/master/graphs/sunburst.svg?token=RX0SNJAVQZ)


## Documentation

For the most recent documentation see [here](https://herearound.github.io/CYTools.jl/dev/).


## Installation for Linux

1. Install `Julia` on your computer. The latest version can be found [here](https://julialang.org/downloads/).
2. Clone this development version of `CYTools.jl`:

    git clone https://github.com/HereAround/CYTools.jl.git

   Alternatively, download `CYTools.jl` to your system.
3. Place your clone/download in a location outside of the `.julia` folder of your home folder.
4. Finally, register and build `CYTools.jl` as follows:

    using Pkg
    Pkg.develop(path="path/to/your/CYTools.jl")
    Pkg.build("CYTools")
