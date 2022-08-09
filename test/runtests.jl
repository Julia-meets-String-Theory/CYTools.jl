using Test
using CYTools
using Oscar

cy = CYHypersurface([1 0; 0 1; -1 -1])

# Add better tests here.
@testset "Generic test" begin
    @test ambient_dim(polytope(cy)) == 2
end
