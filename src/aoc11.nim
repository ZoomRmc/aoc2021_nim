import zero_functional

type
  intA = int8
  P = tuple[x: intA, y: intA]

template `{}`[T: SomeInteger](s: openArray[seq[T]], p: P): T = s[p.y][p.x]

template `{}=`[T: SomeInteger](s: var openArray[seq[T]], p: P, v: T) = s[p.y][p.x] = v

iterator neighboursSafe*(p: P; w, h: int): P =
  let (w, n, e, s) = (p.x > 0, p.y > 0, p.x < w-1, p.y < h-1)
  if w: yield (p.x-1, p.y)
  if w and n: yield (p.x-1, p.y-1)
  if n: yield (p.x, p.y-1)
  if n and e: yield (p.x+1, p.y-1)
  if e: yield (p.x+1, p.y)
  if e and s: yield (p.x+1, p.y+1)
  if s: yield (p.x, p.y+1)
  if s and w: yield (p.x-1, p.y+1)

proc step(map: var openArray[seq[intA]]; w, h: int): int =
  var que: seq[P]
  for p in 0..<h --> map(y=it).map( 0..<w --> map((it.intA, y.intA).P)).flatten():
    map{p}.inc
    que.add p
  while que.len > 0:
    let p = que.pop()
    if map{p} > 9:
      map{p} = 0
      result.inc
      for n in p.neighboursSafe(w, h):
        if map{n} > 0:
          map{n}.inc
          que.add(n)

when isMainModule:
  var input = lines("input/aoc11.txt") --> map(it --> map( (it.ord - '0'.ord).intA))
  let
    (mapW, mapH) = (input[0].len, input.len)
    p1 = 1..100 --> map(input.step(mapW, mapH)).sum()
  echo p1 #1585
  let p2 = 0..high(int) --> index(input.step(mapW, mapH) == mapW*mapH) + 101
  echo p2 #382
