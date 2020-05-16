import npeg

let palindromeParser = peg "S":
  S   <- A * !1
  A   <- ('a' * A * 'a') | 'a'

proc checkStringMatch(s: string) =
  echo "Matching ", s, ", found: ", palindromeParser.match(s).ok

# checkStringMatch("a")
checkStringMatch("aa")
checkStringMatch("aaa")
# checkStringMatch("1")
# checkStringMatch("a1a")
# checkStringMatch("aa1aa")
# checkStringMatch("b1b")
