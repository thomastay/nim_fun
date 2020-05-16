task build, "Builds header and C files":
  exec "nim c --compileOnly --gc:arc --nimCache:cache --noMain --noLinking --header:fib.h -d:release fib.nim"
  exec "cc -O2 -o maths -Icache/ -I$HOME/.choosenim/toolchains/nim-#devel/lib cache/*.c maths.c"
