type
  BinTreeNode = ref object
    data: int
    le, ri: BinTreeNode  #can be nil
  BinTree* = object
    root: BinTreeNode
    count: Natural
  
# To create an empty tree, just make a BinTree object

proc new*(item: int): BinTree =
  let n = BinTreeNode(data: item)
  result.root = n
  result.count = 1

proc add*(tree: var BinTree, item: int) =
    asd

