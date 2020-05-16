import npeg, strutils, tables

type Dict = Table[string, int]

let parser = peg("pairs", d: Dict):
  pairs <- pair * *(',' * *' ' * pair) * !1
  word <- +Alpha
  number <- +Digit
  float <- +Digit * '.' * *Digit
  pair <- >word * '=' * >number:
    d[$1] = parseInt($2)
  pair <- >word * '=' * >float:
    d[$1] = parseFloat($2)

var words: Table[string, int]
doAssert parser.match("one=1,potato=2, tent=3", words).ok
echo words
doAssert parser.match("one=1,potato=2, tent=3.02", words).ok
echo words
doAssert parser.match("one=1,potato=2, tent=3.", words).ok
echo words
