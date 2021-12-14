import zero_functional, std/[strutils, sequtils, tables, strscans, sugar, hashes]

type Pair = (char, char)

## x5 faster but doesn't matter on this input size
func hash(p: Pair): Hash = ( (p[1].ord - 65) shl 5 ) or (p[0].ord - 65)

func unfold(pairStats: sink CountTable[Pair], dic: TableRef[Pair, char],
            cStats: var CountTable[char]): CountTable[Pair] =
  for pair, n in pairStats:
    if dic.hasKey(pair):
      let c = dic[pair]
      result.inc((pair[0], c), n)
      result.inc((c, pair[1]), n)
      cStats.inc(c, n)
    else:
      result.inc(pair, n)


when isMainModule:
  let
    inputS = lines("input/aoc14.txt").toSeq()
    input = inputS[0].strip()
    dic = collect(newTable()):
      for it in inputS.toOpenArray(2,inputS.high) -->
        map(it.scanTuple("$c$c -> $c")) -->
        filter(it[0]).map( (p:(it[1], it[2]), c:it[3]) ): {it.p: it.c}
  var charStats = toCountTable(input)
  var pairStats = 1..input.high --> map( (input[it-1], input[it]) ) -->
    fold( initCountTable[Pair](), (a.inc(it); a) )

  block Part1:
    for _ in 1..10: pairStats = pairStats.unfold(dic, charStats)
    let (minF, maxF) = charStats.values -->
      fold( (min: high(int), max: 0), (min(a.min, it), max(a.max, it)) )
    let p1 = maxF - minF
    echo p1 #2937

  block Part2:
    for _ in 11..40: pairStats = pairStats.unfold(dic, charStats)
    let (minF, maxF) = charStats.values -->
      fold( (min: high(int), max: 0), (min(a.min, it), max(a.max, it)) )
    let p2 = maxF - minF
    echo p2 #3390034818249
