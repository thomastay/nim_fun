# Checks if a necklace can be rotated 
# To form the given string

import strutils

# Easy way
func isValidRotate(a, b: string): bool =
  let a = a & a
  result = b.in(a)

func isEqual(b, a: string, i: int): bool {.inline} =
  let l = len(b)
  for j in 0..<l:
    if b[j] != a[ (i+j) mod l ]:
      return false
  return true

func isValidRotate2(a: string, b: string): bool =
  if len(a) != len(b): return false
  let l = len(b)
  for i in 0..<l:
    if b.isEqual(a, i):
      return true
  return false

when isMainModule:
  assert "pot".isValidRotate("tpo")
  assert "catarang".isValidRotate("rangcata")
  assert "".isValidRotate("")
  assert "pot".isValidRotate2("tpo")
