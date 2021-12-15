import zero_functional, std/[tables, hashes, sets, heapqueue]

type intA = int32

type P = tuple[x: intA, y: intA]

var dis: Table[P, int] # Just to make the following comparison work

proc `<`(a, b: P): bool = dis[a] < dis[b]

iterator neighbours*(p: P; w, h: int): P =
  if p.x > 0: yield (p.x-1, p.y)
  if p.y > 0: yield (p.x, p.y-1)
  if p.x < w-1: yield (p.x+1, p.y)
  if p.y < h-1: yield (p.x, p.y+1)

func getRiskLevel(p: P; input: openArray[seq[intA]]; tileH, tileW: intA): int =
  let x = p.x mod tileW
  let tileX = p.x div tileW
  let y = p.y mod tileH
  let tileY = p.y div tileH
  ((input[y][x] + tileX + tileY) + 8 ) mod 9 + 1

proc dijk_ucs(input: openArray[seq[intA]]; start, exit: P; mapH, mapW: intA; tiles: Positive = 1): int =
  dis.clear
  var
    frontier = toHeapQueue([start])
    p = start
  dis[start] = 0

  while frontier.len > 0:
    let p = frontier.pop()
    for n in p.neighbours(mapW*tiles, mapH*tiles):
      let d = dis[p] + n.getRiskLevel(input, mapH, mapW)
      let hi = if n in dis: dis[n] else: high(int)
      if d < hi:
        dis[n] = d
        frontier.push(n)
  dis[exit]


when isMainModule:
  let
    input = lines("input/aoc15.txt") --> map(it --> map((it.ord - '0'.int).intA))
    (mapW, mapH) = (input[0].len.intA, input.len.intA)
    start = (0.intA, 0.intA).P
    exit1 = (mapW-1, mapH-1).P

  let p1 = input.dijk_ucs(start, exit1, mapH, mapW)
  echo p1 #592

  let exit2 = (mapW*5-1, mapH*5-1).P
  let p2 = input.dijk_ucs(start, exit2, mapH, mapW, 5)
  echo p2 #2897
