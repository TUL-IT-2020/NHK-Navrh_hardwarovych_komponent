--dvojity synchronizator

library ieee;
use ieee.std_logic_1164.all;

entity input_bit_reg is
    port ( clk 	: in  std_logic;
           inp 	: in  std_logic;
           outp 	: out std_logic
			 );
end input_bit_reg;

architecture behavioral of input_bit_reg is
signal reg1 : std_logic;

begin

	process (clk) begin 
		if (clk'event and clk = '1') then 
				reg1 <= inp;
		end if; 
	end process;

	process (clk) begin 
		if (clk'event and clk = '1') then 
				outp <= reg1;
		end if; 
	end process;
	
end behavioral;