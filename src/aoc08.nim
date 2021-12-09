import zero_functional, std/[strutils, tables]

const LenToNum = {2:1, 3:7, 4:4, 7:8}.toTable()

type
  Segment = enum sA, sB, sC, sD, sE, sF, sG
  Signature = set[Segment]

func toSig(s: string): Signature =
  s --> map(ord(it) - 97).fold( Signature({}), (a.incl(Segment(it)); a) )

func decode(s: seq[Signature]): Table[Signature, int] =
  var
    decoded: array[10, Signature]
    pot235: seq[Signature]
    pot069: seq[Signature]
  for sig in s:
    case sig.len:
      of 2..4,7: decoded[LenToNum[sig.len]] = sig
      of 5: pot235.add(sig)
      of 6: pot069.add(sig)
      else: discard
  for p in pot235:
    if (decoded[7] - p).len == 0: decoded[3] = p
    elif (p - decoded[4]).len == 2: decoded[5] = p
    else: decoded[2] = p
  for p in pot069:
    if (p - decoded[4]).len == 2: decoded[9] = p
    elif (p - decoded[7]).len == 3: decoded[0] = p
    else: decoded[6] = p
  for i, sig in decoded:
    result[sig] = i

func toNum(digs: openArray[Signature]; dic: sink Table[Signature, int]): int =
  dic[digs[0]] * 1000 + dic[digs[1]] * 100 + dic[digs[2]] * 10 + dic[digs[3]]

when isMainModule:
  let
    input = lines("input/aoc08.txt") --> map(it.split(" | "))
    .map((
      coding: it[0].splitWhitespace() --> map(toSig),
      digits: it[1].splitWhitespace() --> map(toSig)
    ))
    p1 = input --> map(it[1]).flatten().filter(it.len in {2,3,4,7}).count()
    p2 = input --> map(it.digits.toNum(decode(it.coding))).sum()

  echo p1 #369
  echo p2 #1031553
