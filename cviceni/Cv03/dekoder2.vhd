-- Dekoder (binarni kod na kod 1 z N) pomoci procesu a indexace vektoru

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dekoder2 is
   port (
      x : in std_logic_vector (2 downto 0);
      y : out std_logic_vector (7 downto 0)
   );
end dekoder2;

architecture a_dekoder of dekoder2 is
begin
   process (x)
   begin

      y <= (others => '1');
      y(to_integer(unsigned(x))) <= '0';

   end process;
end a_dekoder;
