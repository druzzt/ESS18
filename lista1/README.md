# RUN:

ghdl -a --ieee=synopsys <NAME>.vhd
cat work*
ghdl -e --ieee=synopsys <NAME>
ghdl -r --ieee=synopsys <NAME>

# GTKWAVE:

ghdl -a --ieee=synopsys <NAME_TB>.vhd
ghdl -e --ieee=synopsys <NAME_TB>
ghdl -r --ieee=synopsys <NAME_TB> --vcd=<NAME>.vcd
gtkwave <NAME>.vcd
