-- typicky KO typu D (vcetne signalu enable)

library IEEE;
use IEEE.std_logic_1164.all;

entity dff_rise is port (
    d: in std_logic;
    clk: in std_logic;
    en: in std_logic;
    q: out std_logic
    );
end dff_rise;

architecture rtl of dff_rise is

begin

  process 
  begin
    wait until rising_edge(clk);
      if en = '1' then
        q <= d;
      end if;
  end process;

end rtl;
