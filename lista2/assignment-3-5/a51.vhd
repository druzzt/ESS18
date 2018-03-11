--------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity lfsr1 is
    Port ( clk : in  STD_LOGIC;
        ld  : in STD_LOGIC;
        data: in  STD_LOGIC_VECTOR(18 downto 0) := (OTHERS => '0');
        R   : out STD_LOGIC
        );
end lfsr1;

ARCHITECTURE first OF lfsr1 IS
  signal q : STD_LOGIC_VECTOR(18 downto 0) := (OTHERS => '0');
BEGIN
  PROCESS(clk, ld, data)
  BEGIN
    if(ld = '1') 
    then
      q <= data;
    elsif(clk'event and clk = '1')
    then
	    q(18 downto 1) <= q(17 downto 0);
	    q(0) <= not(q(18) XOR q(17) XOR q(16) XOR q(13));
    end if;
  END PROCESS;
  R <= q(18);
END first;

--------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity lfsr2 is
    Port ( clk : in  STD_LOGIC;
        ld  : in STD_LOGIC;
        data: in  STD_LOGIC_VECTOR(21 downto 0) := (OTHERS => '0');
        R   : out STD_LOGIC
        );
end lfsr2;

ARCHITECTURE second OF lfsr2 IS
  signal q : STD_LOGIC_VECTOR(21 downto 0) := (OTHERS => '0');
BEGIN

  PROCESS(clk, ld, data)
  BEGIN
    if(ld = '1') 
    then
      q <= data;
    elsif(clk'event and clk = '1')
    then
	    q(21 downto 1) <= q(20 downto 0);
	    q(0) <= not(q(21) XOR q(20));
    end if;
  END PROCESS;

  R <= q(21);
	
END second;

--------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity lfsr3 is
    Port ( clk : in  STD_LOGIC;
        ld  : in STD_LOGIC;
        data: in  STD_LOGIC_VECTOR(22 downto 0) := (OTHERS => '0');
        R   : out STD_LOGIC
        );
end lfsr3;

ARCHITECTURE third OF lfsr3 IS
  signal q : STD_LOGIC_VECTOR(22 downto 0) := (OTHERS => '0');
BEGIN

    PROCESS(clk, ld, data)
    BEGIN
      if(ld = '1')
      then
        q <= data;
      elsif(clk'event and clk = '1')
      then
        q(22 downto 1) <= q(21 downto 0);
        q(0) <= not(q(22) XOR q(21) XOR q(20) XOR q(7));
      end if;
    END PROCESS;

    R <= q(22);
    
END third;
