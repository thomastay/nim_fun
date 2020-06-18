import strutils, os

type
  MinifierState = enum
    Start, Comment, Elt, Field

template isStartOfComment(c: char): bool =
  c == '/' and s[i] == '*'

template changeToCommentFrom(currState: MinifierState) =
  inc i
  state = Comment
  prevState = currState # to backtrack

func minify*(s: string): string =
  ## Implements a very simple CSS minifier
  ## Only for academic use, not suited for production
  ## A real minifier must read a string in buffers
  ## to maximize cache utilization
  ## Simply put, it removes unimportant whitespace
  ## and comments.
  ## It cannot handle nested CSS.
  runnableExamples:
    let s = """
    /* coent */
      a:hover      {   
          font-weight: 600;
              text-decoration: underline;
        pixel-density: 100px   solid bold   30%    margin;
    /* coent */
    """
    let expected = "a:hover{font-weight: 600;text-decoration: underline;pixel-density: 100px solid bold 30% margin;}"
    assert minify(s) == expected

  let n = len(s)
  var state = Start
  var prevState = Start
  result = newStringOfCap(n div 2) # estimated half compression
  let whitespace: set[char] = {'\t'..'\r', ' '}


  # start of state machine
  var i = 0
  while i < n:
    {.computedGoto.}
    case state
    of Start: # strip whitespace, lookout for {
      let c = s[i]
      inc i
      if c in whitespace: continue
      elif isStartOfComment(c):
        changeToCommentFrom(Start)
      else:
        result.add(c)
        if c == '{': state = Elt
    of Elt: # strip whitespace, lookout for : and }
      let c = s[i]
      inc i
      if c in whitespace: continue
      elif isStartOfComment(c):
        changeToCommentFrom(Elt)
      else:
        result.add(c)
        case c
        of '}': state = Start
        of ':': state = Field
        else: discard
    of Field:
      # in a field, must separate whitespace
      # properties in fields are separated by at most one space
      # recreate a single spaced property list, with one space in front
      let semiColonPos = s.find(';', i)
      let slice = s.substr[i..<semiColonPos]
      let properties = slice.splitWhitespace()
      result &= " " & properties.join(" ")
      # loop
      state = Elt
      i = semiColonPos
    of Comment:
      let endComment = s.find("*/", i)
      # loop
      state = prevState # backout from comment state
      i = endComment + 2

proc test(s, expected: string) =
  echo "------- TESTING ----------"
  let m = minify(s)
  echo "------- OUT ----------"
  echo m
  assert m == expected

proc test2() =
  let s = """
  /* global */

  body {
    font-family: sans-serif;
    -webkit-font-smoothing: antialiased;
    margin: 0 20px;
  }
  """
  let expected = "body{font-family: sans-serif;-webkit-font-smoothing: antialiased;margin: 0 20px;}"
  test(s, expected)

proc test1() =
  let s = """
  /* coent */
    a:hover      {   
        font-weight: 600;
            text-decoration: underline;
      pixel-density: 100px   solid bold   30%    margin;
  /* coent */
  }
  """
  let expected = "a:hover{font-weight: 600;text-decoration: underline;pixel-density: 100px solid bold 30% margin;}"
  test(s, expected)

proc testAll() =
  test1()
  test2()

# ---------- Main --------------
when isMainModule:
  case os.paramCount()
  of 0: testAll()
  of 1:
    let s = readFile(os.paramStr(1))
    echo minify(s)
  else:
    echo "Please enter a filename"
