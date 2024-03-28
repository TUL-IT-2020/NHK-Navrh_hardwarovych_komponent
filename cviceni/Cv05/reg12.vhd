-- 12-bitovy registr 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg12 IS
	PORT(
		d		: IN   std_logic_vector(11 DOWNTO 0);
		clk	: IN   std_logic;
		q		: OUT  std_logic_vector(11 DOWNTO 0)
		);
END reg12;

ARCHITECTURE a_reg12 OF reg12 IS
BEGIN
	PROCESS (clk)
	BEGIN
		IF clk'event AND clk = '1' THEN
		q <= d;
		END IF;
	END PROCESS;
END a_reg12;

