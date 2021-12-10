import zero_functional, std/[strutils, sequtils, sets, deques, hashes]

type intA = int8

type P = tuple[x: intA, y: intA]

func hash(p: P): Hash = (p.y shl (sizeOf(intA)*8)) + p.x

template `{}`[T: SomeInteger](s: openArray[seq[T]], p: P): T = s[p.y][p.x]

iterator neighboursSafe*(p: P; w, h: int): P =
  if p.x > 0: yield (p.x-1, p.y)
  if p.y > 0: yield (p.x, p.y-1)
  if p.x < w-1: yield (p.x+1, p.y)
  if p.y < h-1: yield (p.x, p.y+1)

func fillBasin(input: openArray[seq[intA]]; low: P; mapW, mapH: intA): int =
  var basin: HashSet[P]
  var que: Deque[P]
  que.addLast(low)
  while que.len > 0:
    let p = que.popFirst()
    if input{p} != 9 and p notin basin:
      basin.incl(p)
      for pn in filterIt(neighboursSafe(p, mapW, mapH) --> map(it), input{it} != 9):
        que.addLast(pn)
  result = basin.len

proc pushoutInsIfGrt[T: SomeNumber](s: var openArray[T], elem: T) =
  for i, p in s:
    if elem > p:
      for j in countDown(s.high, i+1): s[j] = move s[j-1]
      s[i] = elem
      break

when isMainModule:
  let input = lines("input/aoc09.txt") --> map(it --> map((it.ord - '0'.int).intA))
  let (mapW, mapH) = (input[0].len.intA, input.len.intA)
  var p1 = 0
  var basinSizes: array[3, int]

  for y in 0..<mapH:
    for x in 0..<mapW:
      let
        p = (x.intA, y.intA).P
        height = input{p}
      if not (p.neighboursSafe(mapW, mapH) --> map(input{it}).exists(it <= height)):
        p1.inc(height.int + 1)
        let bSize = input.fillBasin(p, mapW, mapH)
        basinSizes.pushoutInsIfGrt(bSize)

  let p2 = basinSizes --> product()
  echo p1 #514
  echo p2 #1103130

############### Debug
#proc printMap(s: openArray[seq[intA]]) =
#  for l in s:
#    for c in l:
#      stdout.write(
#      if c == 9: "." else: $c)
#    echo ""
