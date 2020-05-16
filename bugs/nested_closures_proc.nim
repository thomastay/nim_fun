proc foo(param1: string): proc =
  proc bar() =
    echo param1
  proc baz() =
    bar()
  result = baz

static:
  let f = foo("potato")
  f()

let f = foo("potato")
f()
