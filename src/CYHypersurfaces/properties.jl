@doc Markdown.doc"""
    polytope(cy::CYHypersurface)

Return the polytope of a Calabi-Yau hypersurface
in a normal toric variety.

```jldoctest
julia> cy = CYHypersurface([1 0; 0 1; -1 -1])
A Calabi-Yau hypersurface

julia> p = polytope(cy)
A polyhedron in ambient dimension 2
```
"""
@attr Polyhedron polytope(cy::CYHypersurface) = cy.polytope
export polytope
