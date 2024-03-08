-- Ctyrkanalovy demultiplexor pomoci procesu a indexace vektoru

library ieee;
use ieee.std_logic_1164.all;

entity dmx1_4 is
   port (
      x : in std_logic;
      a : in integer range 0 to 3;
      y : out std_logic_vector (3 downto 0)
      );
end dmx1_4;

architecture a_dmx1_4 of dmx1_4 is
begin
   process (x, a)
   begin

      y <= (others => '0');
      y(a) <= x;

   end process;
end a_dmx1_4;
