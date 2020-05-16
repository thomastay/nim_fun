type
  Potato = object
    shape: int
    taste: string
  Grapefruit = object
    shape: int
    taste: string

# This works
proc pprint[Fruit](f: Fruit) =
  echo f.shape, f.taste

# Also works
proc ppprint(f: auto) =
  echo f.shape, f.taste

let x = Potato(shape: 1, taste: "potato")
let y = Grapefruit(shape: 2, taste: "grapefruit")
ppprint(x)
ppprint(y)
