import zero_functional, std/strutils

const BSIZE = 5

type
  N = tuple[n: int, drawn: bool]
  Board = array[BSIZE, array[BSIZE, N]]

proc registerDraw(b: var Board; n: Natural) =
  for i in 0..<BSIZE:
    for j in i..<BSIZE:
      if b[i][j].n == n: b[i][j].drawn = true
      if b[j][i].n == n: b[j][i].drawn = true

func isWinner(b: Board): bool =
  for i in 0..<BSIZE:
    var (hWin, vWin) = (true, true)
    for j in 0..<BSIZE:
      hWin = hWin and b[i][j].drawn
      vWin = vWin and b[j][i].drawn
    if hWin or vWin: return true

func winScore(b: Board, draw: Natural): Natural =
  b --> flatten().filter(it.drawn == false).map(it.n).sum() * draw

func buildBoards(input: sink seq[string]): seq[Board] =
  for ln, line in input.toOpenArray(1, input.high) --> map(it.splitWhitespace() --> map(parseInt)):
    let m = ln mod BSIZE
    if m == 0:
      result.add(default(Board))
    for i, n in line.toOpenArray(0, BSIZE-1):
      result[^1][m][i] = (n: n, drawn: false)

when isMainModule:
  let input = lines("input/aoc04.txt") --> map(it).filter(it != "") # doesn't work without dummy map??
  let nums = input[0].split({',', '\n'}) --> map(parseInt)
  var boards = buildBoards(input)

  block Part1:
    var p1: int
    block Drawing:
      for draw in nums:
        boards.mitems --> foreach(it.registerDraw(draw))
        for b in boards:
          if b.isWinner:
            p1 = b.winScore(draw)
            break Drawing
    echo p1 #10680

  block Part2:
    var last: tuple[b: Board, n: Natural]
    var boards2 = boards
    for draw in nums:
      var boardsNew: seq[Board]
      boards2.mitems --> foreach(it.registerDraw(draw))
      for b in boards2:
        if b.isWinner: last = (b, draw.Natural)
        else: boardsNew.add(b)
      boards2 = boardsNew
    let p2 = last.b.winScore(last.n)
    echo p2 #31892
