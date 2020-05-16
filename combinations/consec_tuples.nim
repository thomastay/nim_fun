import sets

const
  MAX_ELT = 70

## Yields the two nonconsecutive elts
## Then the position of the consecutive element
iterator positions(): (int, int, int) =
  yield (0, 1, 2)
  yield (3, 4, 0)
  yield (0, 4, 1)


iterator tup(): array[0..4, int] =
  var sequence: array[0..4, int]
  for (nc1, nc2, c) in positions():
    for conseq in countup(1, MAX_ELT - 2):
      sequence[(c + 0) mod 5] = conseq
      sequence[(c + 1) mod 5] = conseq + 1
      sequence[(c + 2) mod 5] = conseq + 2
      for nonConseq1 in countup(1, MAX_ELT):
        for nonConseq2 in countup(1, MAX_ELT):
          sequence[nc1] = nonConseq1
          sequence[nc2] = nonConseq2
          yield sequence

func numUniqueTuples(): int =
  var allTuples: HashSet[array[0..4, int]]
  for s in tup():
    allTuples.incl(s)
  allTuples.card

when isMainModule:
  echo numUniqueTuples()
