-- realizace 24-bitoveho registru ze dvou 12-bitovych
-- soubor reg12.vhd musi byt soucasti (pridan do) projektu

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg24a IS
	PORT(
		d		: IN   STD_LOGIC_VECTOR(23 DOWNTO 0);
		clk		: IN   STD_LOGIC;
		q		: OUT  STD_LOGIC_VECTOR(23 DOWNTO 0));
END reg24a;

ARCHITECTURE a OF reg24a IS
BEGIN
	reg12a	: ENTITY work.reg12 PORT MAP (d => d(11 DOWNTO 0), clk => clk, 
			  q => q(11 DOWNTO  0));
	reg12b	: ENTITY work.reg12 PORT MAP (d => d(23 DOWNTO 12), clk => clk, 
			  q => q(23 DOWNTO 12));
END a;

