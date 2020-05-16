# Implements a general purpose norm function 
# that works as long as [] and high() functions
# are implemented
import math
type
  Point2 = object
    x: int
    y: int

# A for-loop just calls the items iterator
# So, we can specialize it for the Point2 
# object type
iterator items(p: Point2): int =
  yield p.x
  yield p.y

# The auto is basically a template in C++
# Generics in Nim are duck-typed, like
# C++ templates.
func norm(p: auto): float =
  var acc = 0
  for x in p:
    acc += x ^ 2
  return sqrt(float acc)

# Create our struct and calculate norm
let p = Point2(x: 3446, y: 4456)
echo p.norm
