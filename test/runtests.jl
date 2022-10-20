using Test
using CYTools
using Oscar


# 1. Test utilities

example_string = "4 5  M:201 5 N:7 5 H:1,149 [-296]\n1   1   1   1  -7\n0   2   2   2  -6\n0   0   8   0  -8\n0   0   0   8  -8";
polytopes1 = read_polytopes(example_string, input_type="string")
polytopes2 = fetch_polytopes(h11=4, lattice='N', limit=5)

@testset "Read polytopes" begin
    @test length(polytopes1) == 1
    @test ambient_dim(polytopes1[1]) == 4
    @test length(vertices(polytopes1[1])) == 5
end

@testset "Fetch polytopes" begin
    @test length(polytopes2) == 5
    @test ambient_dim(polytopes2[1]) == 4
end


# 2. Test CY Hypersurfaces
@testset "Calabi-Yau hypersurface" begin
    cy = CYHypersurface([1 0; 0 1; -1 -1])
    @test ambient_dim(polytope(cy)) == 2
end
