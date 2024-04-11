library ieee;
use ieee.std_logic_1164.all;

entity dec_7segm is
	port(
		input4	: in	std_logic_vector(3 downto 0);
		output7	: out	std_logic_vector(6 downto 0)
		);
end dec_7segm;

architecture ar of dec_7segm is
	
begin
	process (input4)
	begin

	case input4 is
		when "0000" => output7 <= "0000001";     
		when "0001" => output7 <= "1001111";
		when "0010" => output7 <= "0010010";
		when "0011" => output7 <= "0000110";
		when "0100" => output7 <= "1001100";
		when "0101" => output7 <= "0100100";
		when "0110" => output7 <= "0100000";
		when "0111" => output7 <= "0001111";
		when "1000" => output7 <= "0000000";
		when "1001" => output7 <= "0000100";
		when "1010" => output7 <= "0001000";
		when "1011" => output7 <= "1100000";
		when "1100" => output7 <= "0110001";
		when "1101" => output7 <= "1000010";
		when "1110" => output7 <= "0110000";
		when "1111" => output7 <= "0111000";
		when others => output7 <= "1111111";
	end case;

	end process;
	
end ar;