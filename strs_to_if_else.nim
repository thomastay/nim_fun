## Compiles a list of strings
## to an if else branching recognizer.
## This is basically what all hand coded lexers do.
## Why do this over perfect hashing?
## Well, this generates compact code, and sometimes
## that might be faster than a lookup in a (potentially large)
## hash table.
## 
## For example, the list of strings
## ["abc", "ad", "add", "bc"]
## will get compiled down to
## ```nim
## case buf[0]
## of 'a':
##  case buf[1]
##  of 'b':
##    return Token.abc
##  of 'd':
##    case buf[2]
##    of 'd':
##      return Token.add
##    else:
##      return Token.ad
##  else:
##    raise newException(TokenError, "Token not found")
## of 'b':
##  case buf[1]:
##  of 'c':
##    return Token.bc
##  else:
##    raise newException(TokenError, "Token not found")
## else:
##   raise newException(TokenError, "Token not found")
## ```

import tables, macros

# dumpTree:
#   case buf[0]
#   of 'a':
#     case buf[1]
#     of 'b':
#       return Token.abc
#     of 'd':
#       case buf[2]
#       of 'd':
#         return Token.add
#       else:
#         return Token.ad
#     else:
#       raise newException(TokenError, "Token not found")
#   of 'b':
#     case buf[1]:
#     of 'c':
#       return Token.bc
#     else:
#       raise newException(TokenError, "Token not found")
#   else:
#     raise newException(TokenError, "Token not found")

# dumpAstGen:
#   case buf[1]:
#   of 'c':
#     return Token.bc
#   else:
#     raise newException(TokenError, "Token not found")

macro strsToLexer(strs: openArray[string]) =
  var tbl: Table[char, seq[NimNode]]
  for str in strs:
    let c: char = str.strVal[0]
    if tbl.hasKeyOrPut(c, @[str]):
      tbl[c].add(str)
  echo tbl




strsToLexer(["abc", "ad", "add", "bc"])