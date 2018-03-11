library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;

-- this is a testbench, but can be any other entity
entity a51_tb is
end a51_tb;

architecture complex of a51_tb is
-- this clock runs at HOW MANY MHz?
constant clock_period : time := 10 ns;

-- clock signal
signal clock : std_logic :=  '0';
-- lines for loading-up LFSRs
signal q1 : std_logic_vector(18 downto 0) := (others => '0');
signal q2 : std_logic_vector(21 downto 0) := (others => '0');
signal q3 : std_logic_vector(22 downto 0) := (others => '0');

-- signal to start loading LFSRs
signal load  : std_logic := '0';
-- outputs from LFSRs
signal LFSR1, LFSR2, LFSR3 : std_logic;
signal result : std_logic := '0';

-- just a reminder what will be tested
component lfsr11
    port(
    clk  : in STD_LOGIC;
    ld   : in STD_LOGIC;
    data : in STD_LOGIC_VECTOR(18 downto 0);
    R    : out STD_LOGIC );
end component;

component lfsr22
    port(
    clk  : in STD_LOGIC;
    ld   : in STD_LOGIC;
    data : in STD_LOGIC_VECTOR(21 downto 0);
    R    : out STD_LOGIC );
end component;

component lfsr33
    port(
    clk  : in STD_LOGIC;
    ld   : in STD_LOGIC;
    data : in STD_LOGIC_VECTOR(22 downto 0);
    R    : out STD_LOGIC );
end component;

-- remember? we defined two architectures for 'lfsr'
for UUT1 : lfsr11 use entity work.lfsr1(first);
for UUT2 : lfsr22 use entity work.lfsr2(second);
for UUT3 : lfsr33 use entity work.lfsr3(third);

begin
-- let's create instances of our LFSRs
UUT1 : lfsr11 port map ( clk => clock, ld => load, data => q1, R => LFSR1 );
UUT2 : lfsr22 port map ( clk => clock, ld => load, data => q2, R => LFSR2 );
UUT3 : lfsr33 port map ( clk => clock, ld => load, data => q3, R => LFSR3 );

-- this will run infinitely, stopping every few ns
clocker : process
    begin
    clock <= not clock;
    wait for clock_period/2;
end process;

-- this will run once and then wait for ever
init : process
    begin
    -- time to tell LFSRs to load up some data
    load <= '1';
    -- and give it to them (to one of them, at least)
    --q1 <= "0101010101010101011";
    --q1 <= "1111111111111111111";
    q1 <= "0000000000000000000";
    --q2 <= "0101010101010101010101";
    --q2 <= "1111111111111111111111";
    q2 <= "0000000000000000000000";
    --q3 <= "01010101010101010101010";
    --q3 <= "11111111111111111111111";
    q3 <= "00000000000000000000000";

    -- even though LFSRs are async, let's wait for a bit...
    wait until clock'event and clock = '0';
    -- ... and let them run freely
    load <= '0';
    -- this process is finished, make it wait ad infinitum
    wait;
end process;

writeOut : process
    variable l : line;
begin
    wait until clock'event and clock = '0';
    result <= LFSR1 xor LFSR2 xor LFSR3;
    write(l, result);
    writeline(output, l);
    wait until clock'event and clock = '1';
end process;


-- okay, what's going on here? well, the 'clocker' process
-- keeps running, changing clk -> NOT clk -> clk -> NOT clk ...
-- and clk is fed to LFSRs, so they are busy working
-- the simulation will continue until you kill it, or specify
-- the stop time using '--stop-time=XXX' switch to ghdl

end complex;
