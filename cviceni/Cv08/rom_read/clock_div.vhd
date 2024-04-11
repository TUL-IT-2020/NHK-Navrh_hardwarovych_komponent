--delicka vstupniho kmitoctu, clk_out = clk_in/(2x(parametr+1))

library ieee;
use ieee.std_logic_1164.all;

ENTITY clock_div IS
	PORT(
		clk_in		: IN	std_logic;
		clk_out		: OUT	std_logic);
END clock_div;

ARCHITECTURE ar OF clock_div IS
	CONSTANT parametr : integer := 7;
	SIGNAL s_clk 		: std_logic := '0';    
	SIGNAL delic 		: integer range 0 to 15;
	
BEGIN
	PROCESS (clk_in)
	BEGIN
		IF (clk_in'event and clk_in = '1') THEN
			delic <= delic+1;
			IF delic = parametr THEN
				delic <= 0;
				s_clk <= not s_clk;
			END IF;
		END IF;
	END PROCESS ;
	
	clk_out <= s_clk;
	
END ar;