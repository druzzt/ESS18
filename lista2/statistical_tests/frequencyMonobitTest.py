import sys
import string
import math

fileinput = sys.argv[1]

with open(fileinput, 'r') as myfile:
    data=myfile.read().replace('\n', '')
    S = 0;
    n = 0;
    for i, ch in enumerate(data):
        if ch == '0':
            S = S - 1
        else:
            S = S + 1

    Sobs = 0;
    Sobs = abs(S) / math.sqrt(len(data))
    P = math.erfc( (Sobs / math.sqrt(2)) )
    print P