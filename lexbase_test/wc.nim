## Very trivial program that counts word in a stream.
## Used to demonstrate lexbase
## Can only handle streams with alphanumeric characters,
## spaces, tabs, and newlines.

import lexbase, streams

type Lexer = object of BaseLexer

proc open(l: var Lexer, stream: Stream) = 
  lexbase.open(l, stream)

proc wordCount(s: Stream): int =
  var l = Lexer()
  var inWord: bool
  l.open(s)

  # edge case: check if first char starts on a word, or is EOF
  case l.buf[0]:
  of lexbase.EndOfFile: return 0
  of ' ', '\t', '\r', '\n': inWord = false
  else: inWord = true

  # Helper function to handle a possible word boundary
  template handleNonWord() {.dirty.} =
    result += int(inWord) # if at word boundary, increment result
    inWord = false

  # Begin main lexing loop
  var pos = 0
  while true:
    case l.buf[pos]:
    of ' ', '\t':
      handleNonWord()
      inc pos
    of '\r':
      handleNonWord()
      pos = l.handleCR(pos)
    of '\n':
      handleNonWord()
      pos = l.handleLF(pos)
    of lexbase.EndOfFile:
      handleNonWord()
      return result
    else: # Non whitespace character
      inWord = true
      inc pos

assert wordCount(newStringStream("  one  two  three")) == 3
assert wordCount(newStringStream("")) == 0
assert wordCount(newStringStream("    ")) == 0
assert wordCount(newStringStream("onewordlong")) == 1
assert wordCount(newStringStream("""
one
two three
four five
""")) == 5
    


    

