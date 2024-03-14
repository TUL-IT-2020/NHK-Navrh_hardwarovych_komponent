--  Klopny obvod typu latch realizovany pomoci procesu

library ieee;
use ieee.std_logic_1164.all;

entity latch is
   port (
      d   : in std_logic;
      clk : in std_logic;
      q   : out std_logic
   );
end latch;

architecture struct of latch is
begin
   process (d, clk)
   begin
      if clk = '1' then
         q <= d;
      end if;
   end process;
end struct;
