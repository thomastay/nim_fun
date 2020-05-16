import typeinfo

type
  genSeq = ref object
    data: Any
    down: genSeq

var intDatum = 3
var strDatum = "hello, world!"
let child = genSeq(data: strDatum.toAny, down:nil)
let a = genSeq(data: intDatum.toAny, down: child)
echo a.data.getInt    # echos 3
echo a.down.data.getString # echos "hello, world!"
