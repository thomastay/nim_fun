gcc -c  -w   -I'/home/thomas/.choosenim/toolchains/nim-#devel/lib' -I/home/thomas/Documents/nim_tutorial/bugs -o stdlib_system.nim.c.o stdlib_system.nim.c
gcc -c  -w   -I'/home/thomas/.choosenim/toolchains/nim-#devel/lib' -I/home/thomas/Documents/nim_tutorial/bugs -o @mnested_closures_proc.nim.c.o @mnested_closures_proc.nim.c
gcc   -o nested_closures_proc  stdlib_io.nim.c.o stdlib_system.nim.c.o @mnested_closures_proc.nim.c.o    -ldl
