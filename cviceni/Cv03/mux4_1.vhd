-- ctyrkanalovy multiplexor pomoci procesu a indexace vektoru

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4_1 is
   port (
      x : in std_logic_vector (3 downto 0);
      a : in std_logic_vector (1 downto 0);
      y : out std_logic
   	  );
end mux4_1;

architecture a_mux4_1 of mux4_1 is
begin
   process (x, a)
   begin

      y <= x(to_integer(unsigned(a)));

   end process;
end a_mux4_1;
