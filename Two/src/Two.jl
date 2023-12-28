module Two

@kwdef struct Round
    green::Int
    red::Int
    blue::Int
end

# make Game (containing vectors) comparable, see https://stackoverflow.com/a/62340938
abstract type Comparable end

@kwdef struct Game <: Comparable
    id::Int
    rounds::Vector{Round}
end

function roundfromstr(str)
    red, green, blue = 0, 0, 0
    for s in eachsplit(str, ',', keepempty=false)
        num, color = split(s)
        if color == "blue"
            blue += parse(Int, num)
        elseif color == "red"
            red += parse(Int, num)
        elseif color == "green"
            green += parse(Int, num)
        else
            throw(ArgumentError("line must contain valid color (" * str * ")"))
        end
    end
    return Round(green=green, red=red, blue=blue)
end

function gamefromstr(str)
    preamble, rounds = split(str, ":")
    _, id = split(preamble)
    return Game(id=parse(Int, id), rounds=roundfromstr.(split(rounds, ";")))
end

import Base.==

function ==(a::T, b::T) where T <: Comparable
    f = fieldnames(T)
    getfield.(Ref(a),f) == getfield.(Ref(b),f)
end

import Base.<=

function <=(a::Round, b::Round)
    a.red <= b.red && a.green <= b.green && a.blue <= b.blue
end

function least_cubes(g::Game)
    Round(
        red=maximum(r -> r.red, g.rounds, init=0),
        green=maximum(r -> r.green, g.rounds, init=0),
        blue=maximum(r -> r.blue, g.rounds, init=0),
    )
end

end # module Two
