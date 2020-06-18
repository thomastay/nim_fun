func f(): string = 
  var a = "hello, world!"
  var b = "lovely weather we're having"
  for i in 1..100_000:
    let temp = a
    a = b
    b = temp
  result = a

for _ in 1..1000:
  echo f()