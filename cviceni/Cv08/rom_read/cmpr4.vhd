--komparator

library ieee;
use ieee.std_logic_1164.ALL;

entity cmpr4 is
    Port ( a_in4		: in  std_logic_vector (3 downto 0);
           b_in4		: in  std_logic_vector (3 downto 0);
           equal_out	: out std_logic
           );
end cmpr4;

architecture behavioral of cmpr4 is

begin

	process (a_in4,b_in4)
	begin
			if (a_in4 = b_in4 ) then 
				equal_out <= '1'; 
			else 
				equal_out <= '0'; 
			end if;
	end process; 

end behavioral;