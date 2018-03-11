#!/bin/bash

#clear
ghdl -a --ieee=synopsys lfsr.vhd

ghdl -e --ieee=synopsys lfsr
# ghdl -e --ieee=synopsys lfsr2
# ghdl -e --ieee=synopsys lfsr3

ghdl -r --ieee=synopsys lfsr
# ghdl -r --ieee=synopsys lfsr2
# ghdl -r --ieee=synopsys lfsr3


ghdl -a --ieee=synopsys lfsr_tb.vhd
ghdl -e --ieee=synopsys lfsr_tb
ghdl -r --ieee=synopsys lfsr_tb --stop-time=10000ns > output.txt
#clear
echo "Compiled."

cd ../statistical_tests
echo "----Frequency Monobit Test----"
python frequencyMonobitTest.py ../assignment-1-2/output.txt
echo "----Frequency Test Within a Block----"
python frequencyTestWithinABlock.py ../assignment-1-2/output.txt $1
echo "----Excursion Test----"
python excursionTest.py ../assignment-1-2/output.txt
