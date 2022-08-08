#######################################
# 1: The Julia type for CYHypersurfaces
#######################################

@attributes mutable struct CYHypersurface
    polytope::Polyhedron{fmpq}
    CYHypersurface(polytope::Polyhedron{fmpq}) = new(polytope)
end
export CYHypersurface


######################
# 2: Generic constructors
######################

@doc Markdown.doc"""
    CYHypersurface(vertices::Matrix{T}) where {T <: IntegerUnion}

Construct the Calabi-Yau hypersurface in a normal toric variety
with rays given as the vertices of a polytope.

# Examples
```jldoctest
julia> CYHypersurface([1 0; 0 1])
A Calabi-Yau hypersurface
```
"""
function CYHypersurface(vertices::Matrix{T}) where {T <: IntegerUnion}
    return CYHypersurface(convex_hull(vertices))
end
export CYHypersurface


######################
# 6: Display
######################s

function Base.show(io::IO, td::ToricDivisor)
    properties_string = ["A Calabi-Yau hypersurface"]
    join(io, properties_string, ", ", " ")
end
