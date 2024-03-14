-- typicky KO typu D (vcetne signalu enable) 

library IEEE;
use IEEE.std_logic_1164.all;

entity dff_if is port (
    d: in std_logic;
    clk: in std_logic;
    en: in std_logic;
    q: out std_logic
    );
end dff_if;

architecture rtl of dff_if is

begin

  process (clk) 
  begin
    if clk'event and clk = '1' then
      if en = '1' then
        q <= d;
      end if;
    end if;
  end process;

end rtl;
