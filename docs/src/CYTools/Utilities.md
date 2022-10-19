```@meta
CurrentModule = CYTools
```

```@contents
Pages = ["Utilities.md"]
```

# Utilities

## Reading polytopes from the Kreuzer-Skarke database

```@docs
read_polytopes(input::String; input_type::String="file", format::String="ks")
fetch_polytopes(; h11::Union{Int, Nothing}=nothing, h12::Union{Int, Nothing}=nothing,
                         h13::Union{Int, Nothing}=nothing, h22::Union{Int, Nothing}=nothing,
                         chi::Union{Int, Nothing}=nothing, lattice::Union{Char, Nothing}=nothing,
                         dim::Int=4, n_points::Union{Int, Nothing}=nothing,
                         n_vertices::Union{Int, Nothing}=nothing, n_dual_points::Union{Int, Nothing}=nothing,
                         n_facets::Union{Int, Nothing}=nothing, limit::Int=1000, timeout::Int=60, raw_output::Bool=false)
```
