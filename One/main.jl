using Pkg

Pkg.activate(".")

using One

println("Solution for part one:")
println(mapreduce(One.PartOne.parseline, +, eachline(open("data/input.txt"))))

println("Solution for part two:")
println(mapreduce(One.PartTwo.parseline, +, eachline(open("data/input.txt"))))
