using Pkg; Pkg.activate(".")

import Two: Round, Game, gamefromstr, least_cubes

println("Solution for part one:")

possible(r::Round) = (<=)(r, Round(red=12, green=13, blue=14))
possible(g::Game) = all(possible.(g.rounds))

println(
    sum(
        map(
            g -> g.id,
            filter(
                possible,
                map(gamefromstr, eachline(open("input.txt")))
            )
        )
    )
)


println("Solution for part two:")

function power(r::Round)
    r.red * r.green * r.blue
end

println(
    sum(
        map(
            power,
            map(
                least_cubes,
                map(gamefromstr, eachline(open("input.txt")))
            )
        )
    )
)

# equivalently
println(
    sum(power.(least_cubes.(gamefromstr.(eachline(open("input.txt"))))))
)
