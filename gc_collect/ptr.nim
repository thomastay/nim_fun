type
  Data = tuple[x, y: int, s: string]

static:
  echo sizeof(Data)

proc main() =
# allocate memory for Data on the heap:
  var d = cast[ptr Data](alloc0(sizeof(Data)))

# create a new string on the garbage collected heap:
  d.s = "abc"

  echo d.s

# tell the GC that the string is not needed anymore:
  echo GC_getStatistics()

# Force the GC to perform a collection, by using a lot of string memory
  var st: string
  for i in 1..1000:
    st &= "kajndjsndkjwni13213j2ij3oi1j3oi21ji3n1lknmlknm1kjn3213uh3oij1oij321kjnm3kj21n3jk3n1kj3n13kj21n3kj21n3uh13iuoija;dlkmslkndkjanbdkjsandkjandkjandkjsandkjwndkjwndkjandj"

  echo GC_getStatistics()

  echo d.s

# free the memory:
  # GC_unref(d.s)
  dealloc(d)

when isMainModule:
  main()
