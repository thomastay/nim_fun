def genDigits(num):
  while num != 0:
    thisDigit = num % 10
    num = num // 10
    yield thisDigit

def hasOneSevenRestAddToN(x, N):
  numSevens = 0
  restSum = 0
  for digit in str(x):
    if digit == '7':
      numSevens += 1
    else:
      restSum += int(digit)
  return numSevens == 1 and restSum == N

def hasOneSevenRestAddToN_old(x, N):
  numSevens = 0
  restSum = 0
  for digit in genDigits(x):
    if digit == 7:
      numSevens += 1
    else:
      restSum += digit
  return numSevens == 1 and restSum == N

def countN(N):
    largest = 10000000
    return sum((1 for x in range(1, largest) if
                hasOneSevenRestAddToN(x,N)))

def countN_old(N):
  result = 0
  largest = 10000000
  for num in range(1, largest):
    if hasOneSevenRestAddToN(num, N):
      result += 1
  return result

print(countN(8))
print(countN(9))
