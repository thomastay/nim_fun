python3 genNim.py 10000 > nim_hello.nim
python3 genC.py 10000 > c_hello.c
time gcc -o c_hello c_hello.c
nim c --verbosity:1 --gc:none nim_hello.nim
rm c_hello* nim_hello*
