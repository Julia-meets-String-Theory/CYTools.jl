#######################################
# 1: The Julia type for CYHypersurfaces
#######################################

@attributes mutable struct CYHypersurface
    polytope::Polyhedron
    CYHypersurface(polytope::Polyhedron) = new(polytope)
end
export CYHypersurface


#######################################
# 2: Generic constructor
#######################################

@doc Markdown.doc"""
    CYHypersurface(vertices::Matrix{Int})

Construct the Calabi-Yau hypersurface in a normal toric variety
with rays given as the vertices of a polytope.

# Examples
```jldoctest
julia> CYHypersurface([1 0; 0 1; -1 -1])
A Calabi-Yau hypersurface
```
"""
function CYHypersurface(vertices::Matrix{Int})
    return CYHypersurface(convex_hull(vertices))
end
export CYHypersurface


#######################################
# 3: Display
#######################################

function Base.show(io::IO, cy::CYHypersurface)
    properties_string = ["A Calabi-Yau hypersurface"]
    join(io, properties_string, ", ", " ")
end
