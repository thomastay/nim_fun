iterator genDigits(x: int): int =
  var num = x
  while num != 0:
    let thisDigit = num mod 10
    num = num div 10
    yield thisDigit

func hasOneSevenRestAddToN(x, N: int): bool =
  var numSevens = 0
  var restSum = 0
  for digit in genDigits(x):
    if digit == 7:
      numSevens += 1
    else:
      restSum += digit
  return numSevens == 1 and restSum == N

func countN(N: int): int =
  const largest = 10000000
  for num in 1..<largest:
    if hasOneSevenRestAddToN(num, N):
      inc result

echo countN(8)
echo countN(9)







