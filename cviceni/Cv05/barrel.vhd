-- 8bitovy Barrel shift registr

library ieee;
use ieee.std_logic_1164.all;

entity barrel is
  port
  (
    inp   : in std_logic_vector(7 downto 0);
    shift : in std_logic;
    outp  : out std_logic_vector(7 downto 0));
end barrel;

architecture behavior of barrel is
begin
  process (inp, shift)
  begin
    if (shift = '0') then
      outp <= inp;
    else
      for i in 1 to inp'high loop
        outp(i) <= inp(i - 1);
      end loop;
      outp(0) <= inp(7);
    end if;
  end process;
end behavior;