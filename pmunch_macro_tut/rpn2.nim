import macros

macro defineCommands(definitions: untyped): untyped =
  result = newstmtlist()
  echo "This is the input to our macro"
  echo definitions.treeRepr
  var enumDef = nnkTypeSection.newTree(
    nnkTypeDef.newTree(
       newIdentNode("Commands"),
       newEmptyNode(),
       nnkEnumTy.newTree(newEmptyNode())
       )
  )
  for i in countup(0, definitions.len - 1, 2):
    let
      enumInfo = definitions[i]
      commandInfo = definitions[i + 1].treeRepr
    enumDef[0][2].add nnkEnumFieldDef.newtree(enumInfo[0], enumInfo[1])
  echo "This is the enum we create!"
  echo enumDef.treeRepr
  static: echo "This is what we want"
  dumpTree:
    type Commands = enum
      Plus = "+", Minus = "-"
    defineCommands:
      Plus = "+"; "Adds two numbers":
        stack.execute(a + b)
      Minus = "-"; "Subtract two numbers":
        stack.execute(b - a)

defineCommands:
  Plus = "+"; "Adds two numbers":
    stack.execute(a + b)
  Minus = "-"; "Subtract two numbers":
    stack.execute(b - a)
