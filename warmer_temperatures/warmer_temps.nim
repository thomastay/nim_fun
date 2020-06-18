## Given a list of daily temperatures T, return a list such that,
## for each day in the input, tells you how many days you would have
## to wait until a warmer temperature. If there is no future day for
## which this is possible, put 0 instead.
## For example, given the list of temperatures 
## T = [73, 74, 75, 71, 69, 72, 76, 73],
## your output should be [1, 1, 4, 2, 1, 1, 0, 0].

func dailyTemps(l: seq[int]): seq[int] =
  ## Implementation details:
  ## tempStack is a list of (int, int)
  ## The first index is the index into the l array
  ## the second is the value itself
  let n = len(l)
  result = newSeq[int](n)
  var tempStack = newSeqOfCap[(int, int)](n)
  for i, temp in l:
    while len(tempStack) > 0 and tempStack[^1][1] < temp:
      let (idx, _) = tempStack.pop()
      result[idx] = (i - idx) # num of days to warmer day
    tempStack.add((i, temp))
      
let test = @[73, 74, 75, 71, 69, 72, 76, 73]
echo dailyTemps(test)

    
