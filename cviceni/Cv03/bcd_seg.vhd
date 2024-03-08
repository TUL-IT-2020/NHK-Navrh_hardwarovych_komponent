-- dekoder BCD na sedmisegmentovy displej

library ieee;
use ieee.std_logic_1164.all;

entity bcd_seg is 
port (
  bcdInputs: in std_logic_vector (3 downto 0);
  segment  : out std_logic_vector (6 downto 0));
end bcd_seg;

architecture a_bcd of bcd_seg is
begin
  process (bcdInputs) 
  begin

    case bcdInputs is
      when "0000" => segment <= "0000001";     
      when "0001" => segment <= "1001111";
      when "0010" => segment <= "0010010";
      when "0011" => segment <= "0000110";
      when "0100" => segment <= "1001100";
      when "0101" => segment <= "0100100";
      when "0110" => segment <= "0100000";
      when "0111" => segment <= "0001111";
      when "1000" => segment <= "0000000";
      when "1001" => segment <= "0000100";
      when others => segment <= "ZZZZZZZ";
    end case;

  end process;
end a_bcd;
