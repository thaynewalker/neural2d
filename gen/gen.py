#!/usr/bin/python

import math
import sys

def printIth(val, top=10):
  return "{ %s }"%" ".join(["1" if i==val else "-1" for i in range(top)])
  

if __name__ == "__main__":
  samples=100
  if len(sys.argv) > 1:
    samples = int(sys.argv[1])+" "
  for i in range(samples):
    out = printIth(i,samples)
    for j in range(10):
      for k in range(10):
        out += " 1 " if j == k and k == i/(samples/10) else "-1 "
    print out
