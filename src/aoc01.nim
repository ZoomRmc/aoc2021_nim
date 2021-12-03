import zero_functional, std/strutils

when isMainModule:
  let input = lines("input/aoc01.txt") --> map(it.strip().parseInt())

  block Part1:
    let p1 = input --> fold( (n: 0, prev: input[0]),
      (a.n + ord(it > a.prev), it)
    ).n
    echo p1 #1298

  block Part2:
    let p2 = 2..input.high --> fold( 0, a+ord(input[it] > input[it-2]) )
    echo p2 #1248
