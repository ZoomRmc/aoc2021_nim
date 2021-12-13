import zero_functional, std/[strutils, sets, strscans, hashes]

type
  intA = int16
  P = tuple[x: intA, y: intA]
  FoldAxis = enum x = 'x', y = 'y'
  Fold = object
    a: FoldAxis
    i: intA

func hash(p: P): Hash = (p.y shl (sizeOf(intA)*8)) + p.x

func foldIt(f: Fold; pts: sink HashSet[P]; highV, highH: var int): HashSet[P] =
  for p in pts.items:
    let ny = if (f.a == y and p.y > f.i): highV - p.y else: p.y
    let nx = if (f.a == x and p.x > f.i): highH - p.x else: p.x
    if (f.a == y and ny < f.i) or (f.a == x and nx < f.i):
      result.incl( (nx.intA, ny.intA).P )
  case f.a:
    of x: highH = f.i - 1
    of y: highV = f.i - 1

when isMainModule:
  var
    pts: HashSet[P]
    folds: seq[Fold]
    highs = (h: 0, v: 0)
  for l in lines("input/aoc13.txt"):
    let (succ, x, y) = l.scanTuple("$i,$i")
    if succ:
      pts.incl((x.intA, y.intA).P)
      highs = (max(highs.h, x), max(highs.v, y))
    else:
      let (succ, fw, i) = l.scanTuple("fold along $w=$i")
      if succ:
        folds.add(Fold(a: parseEnum[FoldAxis](fw), i: i.intA))
  block Part1:
    pts = folds[0].foldIt(pts, highs.v, highs.h)
    let p1 = pts.len
    echo p1 # 807

  block Part2:
    pts = folds.toOpenArray(1, folds.high) --> fold(pts, it.foldIt(a, highs.v, highs.h))

    var p2 = newSeq[string](highs.v + 1)
    for row in p2.mitems:
      for _ in 0..highs.h:
        row.add(' ')

    for p in pts:
      p2[p.y][p.x] = '#'

    for r in p2:
      echo r #LGHEGUEJ
