proc test(s: string) =
  let n = s[0]
  case n
  of '\0': echo "0"
  of '\1': echo "1"
  of '\2': echo "1"
  of 'a': echo "ask"
  else:
    assert false


test(readLine(stdin))
