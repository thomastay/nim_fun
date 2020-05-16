import sets, hashes
import sequtils

#[
func hash(x: HashSet[int]): Hash =
  var h = 0
  for i in x:
    h = h !& hash(i)
  result = !$h
]#

func powerset[T](inset: HashSet[T]): HashSet[HashSet[T]] =
  for i in inset:
    var tmp = result
    for j in result:
      var k = j
      k.incl(i)
      tmp.incl(k)
    result = move(tmp)

echo powerset(toHashSet([1,2,3,4]))
