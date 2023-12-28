using Test
import Two: Round, Game, roundfromstr, gamefromstr, least_cubes

@testset "Round from line" begin

    @test roundfromstr("") == Round(0, 0, 0)
    @test roundfromstr("1 blue") == Round(0, 0, 1)
    @test roundfromstr("1 blue, 2 red") == Round(0, 2, 1)
    @test roundfromstr("1 red, 2 blue, 3 green") == Round(3, 1, 2)
    @test roundfromstr("1 blue, 2 red, 3 green, 3 blue") == Round(3, 2, 4)

end

@testset "Game from line" begin

    @test gamefromstr("Game 1:") == Game(1, [Round(0, 0, 0)])
    @test gamefromstr("Game 1: 1 blue") == Game(1, [Round(0, 0, 1)])
    @test gamefromstr("Game 2: 1 blue, 1 red; 1 red, 1 blue") == Game(2, [Round(0, 1, 1), Round(0, 1, 1)])
    @test gamefromstr("Game 3: 1 blue, 1 red; 1 red, 1 blue;;") == Game(3, [Round(0, 1, 1), Round(0, 1, 1), Round(0, 0, 0), Round(0, 0, 0)])

end

@testset "Round less than" begin

    @test Round(1, 1, 1) <= Round(1, 1, 1)
    @test Round(1, 1, 1) <= Round(1, 1, 2)
    @test Round(1, 1, 1) <= Round(2, 2, 2)
    @test (Round(1, 1, 3) <= Round(1, 1, 1)) == false
    @test (Round(1, 1, 3) <= Round(3, 1, 1)) == false

end

@testset "Game min" begin

    @test least_cubes(Game(1, [])) == Round(0, 0, 0)
    @test least_cubes(Game(1, [Round(1, 1, 1)])) == Round(1, 1, 1)
    @test least_cubes(Game(1, [Round(1, 1, 2), Round(2, 1, 1)])) == Round(2, 1, 2)

end
