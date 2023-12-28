import One: PartOne, PartTwo
using Test

@testset "PartOne Tests" begin

    @testset "Digit Extraction Tests" begin
        @test PartOne.firstdigit("1") == '1'
        @test PartOne.firstdigit("a1") == '1'
        @test PartOne.firstdigit("12") == '1'
        @test PartOne.lastdigit("2") == '2'
        @test PartOne.lastdigit("2a") == '2'
        @test PartOne.lastdigit("12") == '2'
    end

    @testset "Parseline Tests" begin
        @test PartOne.parseline("1") == 11
        @test PartOne.parseline("11") == 11
        @test PartOne.parseline("12") == 12
        @test PartOne.parseline("22") == 22
        @test PartOne.parseline("a23b") == 23
    end

end

@testset "PartTwo Tests" begin

    @testset "String to instruction Tests" begin
        @test PartTwo.stringtoinstruction("", []) == PartTwo.StopI
        @test PartTwo.stringtoinstruction("a", ["b"]) == PartTwo.StopI
        @test PartTwo.stringtoinstruction("x", ["x"]) == PartTwo.DoneI
        @test PartTwo.stringtoinstruction("x", ["a", "x", "c"]) == PartTwo.DoneI
        @test PartTwo.stringtoinstruction("x", ["xa", "xb", "c"]) == PartTwo.ContinueI
        @test PartTwo.stringtoinstruction("xa", ["xa", "xb", "c"]) == PartTwo.DoneI
    end

    @testset "Build string-to-instruction Dict" begin
        @test PartTwo.buildstringtoinstructiondict(Dict(), []) == Dict("" => PartTwo.Stop)
        @test PartTwo.buildstringtoinstructiondict(Dict("a" => 1), ["a"]) == Dict("" => PartTwo.Continue,
                                                                                  "a" => 1)
        @test PartTwo.buildstringtoinstructiondict(Dict("a" => 1), ["a", "b"]) == Dict("" => PartTwo.Continue,
                                                                                       "a" => 1,
                                                                                       "b" => PartTwo.Stop)
        @test PartTwo.buildstringtoinstructiondict(Dict("a" => 1, "bb" => 2), ["a", "b"]) == Dict("" => PartTwo.Continue,
                                                                                                  "a" => 1,
                                                                                                  "b" => PartTwo.Continue,
                                                                                                  "ba" => PartTwo.Stop,
                                                                                                  "bb" => 2)
        @test PartTwo.buildstringtoinstructiondict(Dict("a" => 1, "bb" => 2), ["a", "b", "c"]) == Dict("" => PartTwo.Continue,
                                                                                                       "a" => 1,
                                                                                                       "b" => PartTwo.Continue,
                                                                                                       "c" => PartTwo.Stop,
                                                                                                       "ba" => PartTwo.Stop,
                                                                                                       "bb" => 2,
                                                                                                       "bc" => PartTwo.Stop)
    end

    @testset "First digit" begin
        @test PartTwo.firstdigit("1", Dict("1" => 1)) == 1
        @test PartTwo.firstdigit("a1", Dict("" => PartTwo.Continue, "1" => 1, "a" => PartTwo.Stop)) == 1
        @test PartTwo.firstdigit("baa", Dict("" => PartTwo.Continue, "b" => PartTwo.Stop, "a" => PartTwo.Continue, "aa" => 2)) == 2
    end

    @testset "Parseline" begin
        @test PartTwo.parseline("1") == 11
        @test PartTwo.parseline("one") == 11
        @test PartTwo.parseline("onetwo") == 12
        @test PartTwo.parseline("nineonetwo") == 92
    end
end
