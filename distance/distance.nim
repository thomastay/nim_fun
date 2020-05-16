# Implements a general purpose norm function 
# that works as long as [] and high() functions
# are implemented
import math
type
  Point2 = object
    x: int
    y: int

# Implements [] and high operations for
# our Point2 struct, needed for norm
func `[]`(p: Point2, i: Natural): int =
  case i
  of 0: return p.x
  of 1: return p.y
  else: assert false

# The paradigm is nim is to have a high()
# operator that returns the last working index
# that an iterator will work on. This is because
# ranges in nim are inclusive on both ends.
func high(p: Point2): int = 1

# The auto is basically a template in C++
# Generics in Nim are duck-typed, like
# C++ templates.
func norm(p: auto): float =
  var acc = 0
  for i in 0..high(p):
    acc += p[i] ^ 2
  return sqrt(float acc)

# Create our struct and calculate norm
let p = Point2(x: 3446, y: 4456)
echo p.norm
