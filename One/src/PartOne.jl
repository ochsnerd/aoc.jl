module PartOne

function firstdigit(str)
    return str[findfirst(isdigit, str)]
end

function lastdigit(str)
    return str[findlast(isdigit, str)]
end

function parseline(line)
    return parse(Int, firstdigit(line) * lastdigit(line))
end

end # module PartOne
