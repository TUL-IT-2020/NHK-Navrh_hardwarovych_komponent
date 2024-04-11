-- pamet ROM 8x4 vytvorena uzitim prikazu CASE

library ieee;
use ieee.std_logic_1164.all;

entity rom1 is port (
		address : in std_logic_vector(2 downto 0);
		output : out std_logic_vector(3 downto 0));
end rom1;

architecture a_rtl_rom1 of rom1 is
begin
	process (address)
	begin
		case address is
			when "000"  => output <= "0001" ;
			when "001"  => output <= "0010" ;
			when "010"  => output <= "0100" ;
			when "011"  => output <= "1000" ;
			when "100"  => output <= "1000" ;
			when "101"  => output <= "0100" ;
			when "110"  => output <= "0010" ;
			when "111"  => output <= "0001" ;
			when others => output <= "0000" ;			
		end case;
	end process;		

end a_rtl_rom1;

