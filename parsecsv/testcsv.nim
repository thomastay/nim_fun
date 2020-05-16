import parsecsv

# Prepare a file
let content = """One,Two,Three,Four
1,2,3,4
10,20,30,40
100,200,300,400
"""
writeFile("temp.csv", content)

var p: CsvParser
p.open("temp.csv")
p.readHeaderRow()
while p.readRow():
  echo "new row: "
  for col in items(p.headers):
    echo "##", col, ":", p.rowEntry(col), "##"
p.close()
