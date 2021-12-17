import zero_functional, std/[strscans]

type V = tuple[x: int, y: int]

func inc(v: var V) =
  v = ((if v.x > 0: v.x-1 elif v.x < 0: v.x+1 else: v.x), v.y-1)

func step(p: (int, int); v: V): (int, int) = (p[0]+v.x, p[1]+v.y)


when isMainModule:
  let (_, xa, xb, ya, yb) = readFile("input/aoc17.txt").scanTuple("target area: x=$i..$i, y=$i..$i")
  echo xa, " ", xb, " ", ya, " ", yb

  var ok: seq[V]
  var maxY = 0

  for x in 0..xb:
    block hor:
      for y in countDown(abs(ya)*2, ya):
        var p = (x: 0, y: 0)
        let vInit: V = (x, y)
        var top = p.y
        #echo vInit
        var v = vInit
        while p.x < xb and p.y > ya:
          if v.x == 0 and p.x < xa: # x too slow
            break hor
          if v.y < ya - p.y: # y too fast
            break
          p = p.step(v)
          top = max(top, p.y)
          if p.x in xa..xb and p.y in ya..yb:
            ok.add(vInit)
            maxY = max(maxY, top)
            break
          v.inc
  let p1 = maxY
  echo p1 # 9730
  let p2 = ok.len
  echo p2 # 4110
