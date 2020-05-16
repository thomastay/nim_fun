let s = "global"

proc f2() =
  echo s

proc f1() =
  let s = "f1"
  f2()

f1()
