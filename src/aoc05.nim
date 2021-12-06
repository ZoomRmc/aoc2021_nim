import zero_functional, std/[strscans]

type
  P = tuple[x, y: int]
  L = tuple[s, d: P]
  Map = seq[seq[int]]

func newMap(h, w: int): Map = 0..<h --> map(newSeq[int](w))

func isStraight(l: L): bool = l.s.x == l.d.x or l.s.y == l.d.y

func isDiag(l: L): bool = abs(l.s.x - l.d.x) == abs(l.s.y - l.d.y)

iterator count[T: SomeInteger](x, y: T): T =
  if x < y:
    for n in countup(x, y): yield n
  else:
    for n in countdown(x, y): yield n

iterator lineIt(l: L): P = # if not on the line will cover area between Ps!
  for y in count(l.s.y, l.d.y):
    for x in count(l.s.x, l.d.x):
      yield (x, y)


iterator diagIt(l: L): P =
  let hSgn = if l.s.x < l.d.x: 1 else: -1 # or sgn(l.d.x - l.s.x) from std/math
  let vSgn = if l.s.y < l.d.y: 1 else: -1
  for step in 0..abs(l.s.x - l.d.x):
    yield (x: (l.s.x + step*hSgn), y: (l.s.y + step*vSgn))

when isMainModule:
  let (input, maxP) = lines("input/aoc05.txt") --> fold(
    (s: newSeq[L](), max: (0, 0).P), block:
      var l: L
      if scanf(it, "$i,$i -> $i,$i", l.s.x, l.s.y, l.d.x, l.d.y):
        a.s.add(l)
      (a.s, (max(a.max.x, max(l.s.x, l.d.x)), max(a.max.y, max(l.s.y, l.d.y))))
  )
  var m = newMap(h = maxP.y+1, w = maxP.x+1)

  block Part1:
    for p in input --> filter(it.isStraight).map(lineIt(it) --> map(it)).flatten():
      m[p.y][p.x].inc()
    let overlapCount = m --> map(it --> map(it)).flatten().filter(it >= 2).count()
    echo overlapCount #6687

  block Part2:
    for p in input --> filter(it.isDiag).map(diagIt(it) --> map(it)).flatten():
      m[p.y][p.x].inc()
    let overlapCount = m --> map(it --> map(it)).flatten().filter(it >= 2).count()
    echo overlapCount #19851

################ Debug
#const test = """0,9 -> 5,9
#8,0 -> 0,8
#9,4 -> 3,4
#2,2 -> 2,1
#7,0 -> 7,4
#6,4 -> 2,0
#0,9 -> 2,9
#3,4 -> 1,4
#0,0 -> 8,8
#5,5 -> 8,2"""

#proc printMap(m: Map) =
#  for l in m:
#    for n in l: (if n == 0: stdout.write('.') else: stdout.write(n))
#    echo ""
