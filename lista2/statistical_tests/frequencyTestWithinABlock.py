import sys
import string
import math
from scipy import special

fileinput = sys.argv[1]
M = int(sys.argv[2])

with open(fileinput, 'r') as myfile:
    data=myfile.read().replace('\n', '')
    
    PiArray = [];
    N = math.floor(len(data)/M)

    for i, ch in enumerate(data):
        if (i % M == 0 and i != 0):
            subSum = 0;
            for j, ch in enumerate(data[i-M:i]):
                if (ch == '1'):
                    subSum = subSum + 1;
            PiArray.append( subSum / M);

    BigSum = 0;
    for val in PiArray:
        BigSum = BigSum + (val - (1/2))**2

    Xpow2 = 4*M*BigSum

    Pval = special.gammainc( (N/2), Xpow2/2 )
    print Pval
    