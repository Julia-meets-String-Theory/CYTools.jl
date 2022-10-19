@doc Markdown.doc"""
read_polytopes(input::String; input_type::String="file", format::String="ks")

Read the polytopes from a string or file. The parameter `input` can serve the
input string or the filename depending on whether the keyword argument `input_type`
is set to "string" or "file". Currently, only the format in the Kreuzer-Skarke
database is supported, but in the future we may support weight systems.

# Examples
```jldoctest
julia> example_string = "4 5  M:201 5 N:7 5 H:1,149 [-296]\n1   1   1   1  -7\n0   2   2   2  -6\n0   0   8   0  -8\n0   0   0   8  -8";

julia> read_polytopes(example_string, input_type="string")
1-element Vector{Matrix{Int64}}:
 [1 0 0 0; 1 2 0 0; … ; 1 2 0 8; -7 -6 -8 -8]
```
"""
function read_polytopes(input::String; input_type::String="file", format::String="ks")
    if input_type ∉ ("file", "string")
        throw(DomainError(input_type, "input_type must be either \"file\" or \"string\""))
    end
    if input_type == "file"
        open(input, "r") do f
           lines = split(read(f, "r"), "\n")
        end
    else
        lines = split(input, "\n")
    end
    n_yielded = 0
    if format == "ws"
        throw(ErrorException("Reading weight systems is not yet supported."))
    elseif format != "ks"
        throw(DomainError(format, "Unsupported format. Options are \"ks\" and \"ws\"."))
    end
    i = 1
    n_lines = length(lines)
    poly_verts = Vector{Matrix{Int}}(undef, 0)
    while i <= n_lines
        l = lines[i]
        if occursin("M:", l)
            h = split(l)
            n, m = parse(Int, h[1]), parse(Int, h[2])
            n_lines_poly = n
            transpose = m > n
            if transpose
                n, m = m, n
            end
            vert = Matrix{Int}(undef, n, m)
            for j in 1:n_lines_poly
                i += 1
                l = lines[i]
                if transpose
                    vert[:,j] = [parse(Int, c) for c in split(l)]
                else
                    vert[j,:] = [parse(Int, c) for c in split(l)]
                end
            end
            push!(poly_verts, vert)
        end
        i += 1
    end
    poly_verts
end
export read_polytopes

@doc Markdown.doc"""
fetch_polytopes(; h11::Union{Int, Nothing}=nothing, h12::Union{Int, Nothing}=nothing,
                         h13::Union{Int, Nothing}=nothing, h22::Union{Int, Nothing}=nothing,
                         chi::Union{Int, Nothing}=nothing, lattice::Union{Char, Nothing}=nothing,
                         dim::Int=4, n_points::Union{Int, Nothing}=nothing,
                         n_vertices::Union{Int, Nothing}=nothing, n_dual_points::Union{Int, Nothing}=nothing,
                         n_facets::Union{Int, Nothing}=nothing, limit::Int=1000, timeout::Int=60, raw_output::Bool=false)

Fetch polytopes from the Kreuzer-Skarke database or the Schöller-Skarke
database. The data is fetched from the websites
http://hep.itp.tuwien.ac.at/~kreuzer/CY/ and
http://rgc.itp.tuwien.ac.at/fourfolds/ respectively.

Supported keyword arguments:
- `h11::Int`: Specifies the Hodge number $h^{1,1}$ of the Calabi-Yau hypersurface.
- `h12::Int`: Specifies the Hodge number $h^{1,2}$ of the Calabi-Yau hypersurface.
- `h13::Int`: Specifies the Hodge number $h^{1,3}$ of the Calabi-Yau hypersurface.
- `h22::Int`: Specifies the Hodge number $h^{2,2}$ of the Calabi-Yau hypersurface.
- `chi::Int`: Specifies the Euler characteristic of the Calabi-Yau hypersurface.
- `lattice::Char`: Specifies the lattice on which the polytope is defined.
  Options are 'N' and 'M'. Has to be specified if the Hodge numbers or the Euler
  characteristic is specified.
- `dim::Int`: The dimension of the polytope. The only available options are 4 and 5.
- `n_points::Int`: Specifies the number of lattice points of the desired polytopes.
- `n_vertices::Int`: Specifies the number of vertices of the desired polytopes.
- `n_dual_points::Int`: Specifies the number of points  of the dual polytopes of
  the desired polytopes.
- `n_facets::Int`: Specifies the number of facets of the desired polytopes.
- `limit::Int=1000`: Specifies the maximum number of fetched polytopes.
- `timeout::Int=60`: Specifies the maximum number of seconds to wait for the server
  to return the data.
- `raw_output::Bool=false`: Return the raw string obtained from the server.

# Examples
```jldoctest
julia> fetch_polytopes(; h11=4, lattice='N', limit=5)
5-element Vector{Matrix{Int64}}:
 [1 0 0 0; -1 0 0 0; … ; 1 0 1 2; -1 -2 -3 -2]
 [1 0 0 0; 0 1 0 0; … ; -1 -1 1 1; 0 0 -1 -1]
 [1 0 0 0; 0 1 0 0; … ; 0 0 1 3; -1 1 -2 -3]
 [1 0 0 0; 0 1 0 0; … ; -1 -3 -1 -2; -2 0 -1 0]
 [1 0 0 0; 0 1 0 0; … ; 1 1 1 2; -3 -1 -1 -2]
```
"""
function fetch_polytopes(; h11::Union{Int, Nothing}=nothing, h12::Union{Int, Nothing}=nothing,
                         h13::Union{Int, Nothing}=nothing, h22::Union{Int, Nothing}=nothing,
                         chi::Union{Int, Nothing}=nothing, lattice::Union{Char, Nothing}=nothing,
                         dim::Int=4, n_points::Union{Int, Nothing}=nothing,
                         n_vertices::Union{Int, Nothing}=nothing, n_dual_points::Union{Int, Nothing}=nothing,
                         n_facets::Union{Int, Nothing}=nothing, limit::Int=1000, timeout::Int=60, raw_output::Bool=false)
    if dim ∉ (4,5)
        throw(DomainError(dim, "Only polytopes of dimension 4 or 5 are available."))
    end
    if !isnothing(lattice) && lattice ∉ ('N', 'M')
        throw(DomainError(lattice, "Options for lattice are 'N' and 'M'."))
    end
    if dim == 4
        if !isnothing(h13) || !isnothing(h22)
            @warn "Ignoring inputs for h13 and h22."
        end
        if (isnothing(lattice) && (!isnothing(h11) || !isnothing(h12) || !isnothing(chi)))
            throw(ErrorException("Lattice must be specified when Hodge numbers or Euler characteristic are given."))
        end
        if lattice == 'N'
            h11, h12 = h12, h11
            chi = (isnothing(chi) ? nothing : -chi)
        end
        if (!isnothing(chi) && !isnothing(h11) && !isnothing(h12) && chi != 2*(h11-h21))
            throw(ErrorException("Inconsistent Euler characteristic input."))
        end
        variables = (h11, h12, n_points, n_vertices, n_dual_points, n_facets, chi, limit)
        names = ("h11", "h12", "M", "V", "N", "F", "chi", "L")
        query = Dict{String, String}()
        for (n,v) in zip(names, variables)
            if !isnothing(v)
                query[n] = string(v)
            end
        end
        r = HTTP.request("GET", "http://quark.itp.tuwien.ac.at/cgi-bin/cy/cydata.cgi",
                         query=query, connect_timeout=timeout, readtimeout=timeout)
    else
        if isnothing(lattice) && (!isnothing(h11) || !isnothing(h13))
            throw(ErrorException("Lattice must be specified when h11 or h13 are given."))
        end
        if lattice == 'N'
            h11, h13 = h13, h11
        end
        if (!isnothing(chi) && !isnothing(h11) && !isnothing(h12) && !isnothing(h13) && chi != 48+6*(h11-h12+h13))
            throw(ErrorException("Inconsistent Euler characteristic input."))
        end
        if (!isnothing(h22) && !isnothing(h11) & !isnothing(h12)& !isnothing(h13) && h22 != 44+6*h11-2*h12+4*h13)
            throw(ErrorException("Inconsistent h22 input."))
        end
        variables = (h11, h12, h13, h22, chi, limit)
        names = ("h11", "h12", "h13", "h22", "chi", "limit")
        url = "http://rgc.itp.tuwien.ac.at/fourfolds/db/5d_reflexive"
        for (n,v) in zip(names, variables)
            if !isnothing(v)
                url *= ",$n=$v"
            end
        end
        url *= ".txt"
        r = HTTP.request("GET", url, connect_timeout=timeout, readtimeout=timeout)
    end
    if raw_output
        return String(r.body)
    end
    read_polytopes(String(r.body), input_type="string", format=(dim==4 ? "ks" : "ws"))
end
export fetch_polytopes
