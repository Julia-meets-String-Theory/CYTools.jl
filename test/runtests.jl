using Test
using CYTools
using Oscar


# Add better tests here.
@testset "Generic test" begin
    cy = CYHypersurface([1 0; 0 1; -1 -1])
    @test ambient_dim(polytope(cy)) == 2
end
