import os
import strutils
import sequtils
import algorithm
import sugar

proc numPart(n, k: int): int =
  if n == k:
    1
  elif n < k or n <= 0 or k <= 0:
    0
  else:
    numPart(n-k,k) + numPart(n-1, k-1)

proc printParts(n, k: int): seq[seq[int]] =
  if n == k and n > 0:
    result = @[repeat(1,n)]
  elif n > k and n > 0 and k > 0:
    let startWithOne = printParts(n-1, k-1)
    let startWithElse = printParts(n-k, k)
    result = startWithOne.map(x => x & @[1]) &
              startWithElse.map(x => x.mapIt(it+1))

assert numPart(3, 3) == 1
assert numPart(10, 3) == 8

let n = paramStr(1).parseInt()
let k = paramStr(2).parseInt()
echo "Number of integer parts of ", n, " into ", k, " is: ", numPart(n,k)
for i, elt in printParts(n,k):
  echo i+1, ": ", elt.reversed()
