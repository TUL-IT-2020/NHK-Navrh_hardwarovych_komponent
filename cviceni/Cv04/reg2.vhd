-- registr s asynchronni predvolbou

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg2 IS
	PORT
	(
	d, data 	: IN std_logic_vector(7 downto 0);
	clk, load	: IN std_logic;
	q		: OUT std_logic_vector(7 downto 0)
	);
END reg2;

ARCHITECTURE a_reg2 OF reg2 IS
BEGIN

	PROCESS (clk, load, data)                      
	BEGIN
	    IF load = '1' THEN  			 
	        q <= data;
	    ELSIF clk'EVENT AND clk = '1' THEN
	        q <= d;
	    END IF;
	END PROCESS;
	
END a_reg2;

