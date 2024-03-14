-- citac modulo 50

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY count50 IS

	PORT
	(
	clk	: IN	std_logic;
	q 	: OUT std_logic_vector(5 downto 0)
	);
	
END count50;

ARCHITECTURE a_count50 OF count50 IS
BEGIN

   PROCESS (clk)
      VARIABLE	cnt	: INTEGER RANGE 0 TO 63;
      CONSTANT	modulus : INTEGER := 50;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
	 IF cnt = modulus THEN
	    cnt := 0;
	 ELSE
	    cnt := cnt + 1;
	 END IF;
      END IF;

   q <= std_logic_vector(to_unsigned(cnt,6));

   END PROCESS;

END a_count50;

