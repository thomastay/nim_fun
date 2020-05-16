import strutils, sequtils, sugar, strformat

type Matrix = seq[seq[bool]]

proc `$`(m: Matrix): string =
  for row in m:
    let zeroRow = row.map(x => (if x: 1 else: 0))
    result.add(zeroRow.join(", ") & "\n")

func toMatrix(m: seq[seq[int]]): Matrix =
  for row in m:
    let toBoolRow = row.mapIt(it == 1)
    result.add(toBoolRow)

proc warshall(m: Matrix): Matrix =
  result = m    # Copy m to the result variable
  let n = high(m) # High(m) is the number of rows - 1
  for k in 0..n:
    echo fmt"W[{k+1}] = "
    for i in 0..n:
      for j in 0..n:
        result[i][j] = result[i][j] or (result[i][k] and result[k][j])
    echo result

let x = @[
  @[0, 0, 0, 0, 0],
  @[0, 0, 1, 0, 1],
  @[0, 0, 0, 0, 1],
  @[1, 0, 0, 0, 0],
  @[0, 1, 1, 0, 0],
  ].toMatrix()
echo "Original Matrix"
echo x
discard warshall(x)
