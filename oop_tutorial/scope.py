s = "global"

def f2():
    print(s)

def f1():
    s = "f1"
    f2()

f1()
