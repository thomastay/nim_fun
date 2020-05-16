#/bin/env/python3
import sys

num_lines = int(sys.argv[1])

print("#include <stdio.h>")
print("int main(){")
for _ in range(num_lines):
    print('puts("Hello, world!");')
print("return 0;")
print("}")

