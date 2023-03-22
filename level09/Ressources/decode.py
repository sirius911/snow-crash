#! /usr/bin/python
import sys

str = sys.argv[1]
new_str = ''
for i, c in enumerate(str):
    new_c = chr(ord(c) - i)
    new_str += new_c
print(new_str)
