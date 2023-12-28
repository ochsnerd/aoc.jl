module PartTwo


@enum InstructionInternal StopI ContinueI DoneI
@enum Instruction Stop Continue

function stringtoinstruction(str, numberwords)
    matches = findall(number -> startswith(number, str), numberwords)
    if length(matches) == 0
        return StopI
    end
    if length(matches) == 1 && str == numberwords[matches[1]]
        return DoneI
    end
    return ContinueI
end

function buildstringtoinstructiondict(numberwords, alphabet)
    d = Dict{String, Union{Instruction, Int}}()
    to_check = [""]
    while !isempty(to_check)
        x = pop!(to_check)
        instruction = stringtoinstruction(x, collect(keys(numberwords)))
        if instruction == DoneI
            d[x] = numberwords[x]
        elseif instruction == ContinueI
            d[x] = Continue
            append!(to_check, (x * c for c in alphabet))
        else
            d[x] = Stop
        end
    end
    return d
end

function firstdigit(line, instructiondict)
    l = length(line)
    for i in 1:l
        for j in i:l
            instruction = instructiondict[line[i:j]]
            if instruction == Stop
                break
            elseif instruction == Continue
                continue
            else
                return instruction
            end
        end
    end
end

stringstonumbers = merge(
    Dict(
        "one" => 1,
        "two" => 2,
        "three" => 3,
        "four" => 4,
        "five" => 5,
        "six" => 6,
        "seven" => 7,
        "eight" => 8,
        "nine" => 9,
    ),
    Dict(
        string(i) => i for i in 1:9
    ))

function reversekeys(d)
    out = Dict()
    for (k, v) in d
        out[reverse(k)] = v
    end
    return out
end

alphabet = [[string(Char(l)) for l in 97:122]; [string(i) for i in 1:9]]

instructions = buildstringtoinstructiondict(stringstonumbers, alphabet)
reverseinstructions = buildstringtoinstructiondict(reversekeys(stringstonumbers), alphabet)

function parseline(line)
    10 * firstdigit(line, instructions) + firstdigit(reverse(line), reverseinstructions)
end

end # module PartTwo
