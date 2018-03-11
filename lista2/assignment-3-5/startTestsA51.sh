#!/bin/bash

#clear
ghdl -a --ieee=synopsys a51.vhd

ghdl -e --ieee=synopsys lfsr1
ghdl -e --ieee=synopsys lfsr2
ghdl -e --ieee=synopsys lfsr3

ghdl -r --ieee=synopsys lfsr1
ghdl -r --ieee=synopsys lfsr2
ghdl -r --ieee=synopsys lfsr3


ghdl -a --ieee=synopsys a51_tb.vhd
ghdl -e --ieee=synopsys a51_tb
ghdl -r --ieee=synopsys a51_tb --stop-time=10000ns > output.txt
#clear
echo "Compiled."

cd ../statistical_tests
echo "----Frequency Monobit Test----"
python frequencyMonobitTest.py ../assignment-3-5/output.txt
echo "----Frequency Test Within a Block----"
python frequencyTestWithinABlock.py ../assignment-3-5/output.txt $1
echo "----Excursion Test----"
python excursionTest.py ../assignment-3-5/output.txt
