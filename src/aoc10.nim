import zero_functional, std/[algorithm]

const DIC = (
    br: ['(','[','{','<',')',']','}','>'],
    sc: [3, 57, 1197, 25137] )

type Brace = enum ParO, BraO, CurO, AngO, ParC, BraC, CurC, AngC

func parseBrace(c: char): Brace = # Invalid chars map to Par0!
  for i in 0..7: (if DIC.br[i] == c: return i.Brace)

func close(b: Brace): Brace = Brace(b.ord + 4)

func score1(b: Brace): int = DIC.sc[b.ord - 4]

func score2(b: Brace): int = b.ord - 3

func eval(s: string): (int, int) =
  var stack: seq[Brace]
  for c in s:
    let b = parseBrace(c)
    if b in ParO..AngO: stack.add(close(b))
    else:
      if b != stack[^1]: return (score1(b), 0)
      else: stack.setLen(stack.high)
  ( 0, countDown(stack.high, 0) --> map(stack[it]).fold(0, a*5+score2(it)) )


when isMainModule:
  let (p1, p2s) = lines("input/aoc10.txt") --> map(eval)
    .fold( (score: 0, pts: newSeq[int]()), block:
      if it[1] > 0: a.pts.add it[1]
      (a.score+it[0], a.pts)
    )
  let p2 = p2s.sorted[p2s.len div 2]

  echo p1 #367059
  echo p2 #1952146692
