-- Citac modulo 10

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulo10 is
   port (
      reset : in std_logic;
      clk : in std_logic;
      q : out std_logic_vector (3 downto 0)
   );
end modulo10;

architecture struct of modulo10 is
begin
   process (reset, clk)
      variable cnt : unsigned (3 downto 0);
   begin
      if reset = '1' then
         cnt := (others => '0');
      elsif clk'event and clk = '1' then
         if cnt = 9 then
            cnt := (others => '0');
         else
            cnt := cnt + 1;
         end if;
      end if;
      q <= std_logic_vector (cnt);
   end process;
end struct;
