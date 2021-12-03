import zero_functional, std/[bitops, sequtils]
from std/strutils import parseBinInt

func criteriaFilter(src: openArray[uint]; highB: int, most: static bool): uint =
  var s = toSeq(src)
  var bit = highB
  while s.len > 1 and bit >= 0:
    let
      half = s.len div 2
      setBitsCount = s --> fold(0, a+ord(it.testBit(bit)))
      moreSet = setBitsCount >= half
    s = s --> filter(it.testBit(bit) == (when most: moreSet else: not moreSet))
    bit.dec()
  s[0]

when isMainModule:
  let
    (maxN, input) = lines("input/aoc03.txt") -->
      map(parseBinInt(it).uint).fold( (max: 0'u, s: newSeq[uint]()), block:
        a.s.add(it)
        ((if it > a.max: it else: a.max), a.s)
      )
    highB = maxN.fastLog2

    setBitsCount = input --> fold( newSeq[int](highB + 1), block:
      for bit in 0..highB:
        a[bit] += ord(it.testBit(bit))
      a
    )

  block Part1:
    let
      half = input.len div 2
      gamma = 0..highB --> filter(setBitsCount[it] > half)
        .fold(0'u, (a.setBit(it); a))
      epsilon = gamma.flipMasked(0..highB)
      p1 = gamma * epsilon
    echo p1 #3847100

  block Part2:
    let
      oxRate = input.criteriaFilter(highB, true)
      co2Rate = input.criteriaFilter(highB, false)
      p2 = oxRate * co2Rate
    echo p2 #4105235
