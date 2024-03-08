-- Dekoder (binarni kod na kod 1 z N) pomoci procesu a case

library ieee;
use ieee.std_logic_1164.all;

entity dekoder1 is
   port (
      x : in std_logic_vector (2 downto 0);
      y : out std_logic_vector (7 downto 0)
   );
end dekoder1;

architecture a_dekoder of dekoder1 is
begin
   process (x) 
   begin
      case x is
         when "000" => y <= "11111110";
         when "001" => y <= "11111101";
         when "010" => y <= "11111011";
         when "011" => y <= "11110111";
         when "100" => y <= "11101111";
         when "101" => y <= "11011111";
         when "110" => y <= "10111111";
         when "111" => y <= "01111111";
         when others => null; 
      end case;
   end process;
end a_dekoder;
