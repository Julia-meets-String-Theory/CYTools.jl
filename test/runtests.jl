using CYTools
using Test

cy = CYHypersurface([1 0; 0 1; -1 0; 0 -1]);

# Add better tests here.
@testset "Generic test" begin
    @test 1+1 == 2
end
