import os, strutils, sequtils

proc main() =
  if paramCount() < 1:
    quit("Usage: x-sexpr.x 1000")
  let
    s = readFile(paramStr(1)).splitWhitespace().map(parseFloat)
  echo "Average= ", s.foldl(a + b)/float(s.len)

main()
