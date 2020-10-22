#!/usr/bin/env/python3
from enum import Enum, auto
import sys


class MinifierState(Enum):
    Start = auto()
    Field = auto()
    Elt = auto()
    Comment = auto()


# See cssMinify.nim for the full details of the implementation
def minify(s: str) -> str:
    """
    Implements a very simple CSS minifier.
    Only for academic use, not suited for production.
    A real minifier must read a string in buffers
    to maximize cache utilization.
    Simply put, it removes unimportant whitespace and comments.
    It cannot handle nested CSS.
    """
    n = len(s)
    state = MinifierState.Start
    prevState = MinifierState.Start
    result = ""

    # start of state machine
    i = 0
    while i < n:
        if state == MinifierState.Start:
            c = s[i]
            i += 1
            if c.isspace():
                continue
            elif c == "/" and s[i] == "*":
                i += 1
                state = MinifierState.Comment
                prevState = MinifierState.Start  # to backtrack
            else:
                result += c
                if c == "{":
                    state = MinifierState.Elt
        elif state == MinifierState.Elt:  # strip whitespace, lookout for : and }
            c = s[i]
            i += 1
            if c.isspace():
                continue
            elif c == "/" and s[i] == "*":
                i += 1
                state = MinifierState.Comment
                prevState = MinifierState.Elt  # to backtrack
            else:
                result += c
                if c == "}":
                    state = MinifierState.Start
                elif c == ":":
                    state = MinifierState.Field
        elif state == MinifierState.Field:
            # in a field, must separate whitespace
            # properties in fields are separated by at most one space
            # recreate a single spaced property list
            semiColonPos = s.find(";", i)
            slic = s[i:semiColonPos]
            properties = slic.split()
            result += " ".join(properties)
            # loop
            state = MinifierState.Elt
            i = semiColonPos
        elif state == MinifierState.Comment:
            endComment = s.find("*/", i)
            # loop
            state = prevState  # backout from comment state
            i = endComment + 2
    return result


if __name__ == "__main__":
    if len(sys.argv) == 2:
        filename = sys.argv[1]
        with open(filename, "r") as f:
            m = f.read()
            print(minify(m))

