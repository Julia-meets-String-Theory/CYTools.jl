using Test
using CYTools
using Oscar


# 1. Test reading polytopes

example_string = "4 5  M:201 5 N:7 5 H:1,149 [-296]\n1   1   1   1  -7\n0   2   2   2  -6\n0   0   8   0  -8\n0   0   0   8  -8";
polytopes1 = read_polytopes(example_string, input_type="string")

@testset "Test result from reading polytopes" begin
    @test length(polytopes1) == 1
    @test ambient_dim(polytopes1[1]) == 4
    @test length(vertices(polytopes1[1])) == 5
end

@testset "Test error messages while reading polytopes" begin
    @test_throws DomainError read_polytopes(example_string, input_type="blabla")
    @test_throws ErrorException read_polytopes(example_string, input_type="string", format="ws")
    @test_throws DomainError read_polytopes(example_string, input_type="string", format="blabla")
end


# 2. Test fetching polytopes

polytopes2 = fetch_polytopes(h11=4, lattice='N', limit=5)

@testset "Test fetching polytopes" begin
    @test length(polytopes2) == 5
    @test ambient_dim(polytopes2[1]) == 4
end

@testset "Test error messages while fetching polytopes" begin
    @test_throws DomainError fetch_polytopes(h11=4, lattice='N', limit=5, dim=2)
    @test_throws ErrorException fetch_polytopes(h11=4, limit=5, dim=4)
    @test_throws ErrorException fetch_polytopes(h11=4, h12=3, chi=3, limit=5, dim=4)
    @test_throws ErrorException fetch_polytopes(h11=4, h12=3, h13=2, chi = 0, limit=5, dim=5)
    @test_throws ErrorException fetch_polytopes(h11=4, h12=3, h13=2, h22 = 0, limit=5, dim=5)
end


# 3. Test CY Hypersurfaces
@testset "Calabi-Yau hypersurface" begin
    cy = CYHypersurface([1 0; 0 1; -1 -1])
    @test ambient_dim(polytope(cy)) == 2
end
