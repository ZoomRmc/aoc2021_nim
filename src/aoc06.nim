import zero_functional, std/[strutils, math]

const
  D1 = 80
  D2 = 256

type Fishes = array[9, int]

func progn(fish: Fishes; days: int): Fishes =
  result = fish
  for day in 0..<days:
    var new = result[0]
    for i in 0..7:
      result[i] = result[i+1]
    result[6] += new
    result[8] = new

when isMainModule:
  when not defined(release):
    const TEST = [0,1,1,2,1,0,0,0,0]
    doAssert progn(TEST, 18).sum() == 26
    doAssert progn(TEST, D1).sum() == 5934

  let fish = (readFile("input/aoc06.txt").strip()).split(',') --> map(parseInt)
    .fold( default(Fishes), (a[it].inc; a) )


  let p1 = progn(fish, D1).sum()
  echo p1 #386755
  let p2 = progn(fish, D2).sum()
  echo p2 #1732731810807
