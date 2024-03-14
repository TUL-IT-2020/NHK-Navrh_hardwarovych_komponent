-- registr rizeny nabeznou hranou s asynchronnim resetem

library ieee;
use ieee.std_logic_1164.all;

entity reg1 is
  port
  (
    d, clk, clr : in std_logic;
    q           : out std_logic
  );
end reg1;

architecture a_reg1 of reg1 is
begin

  process (clk, clr)
  begin
    if clr = '1' then
      q <= '0';
    elsif clk'EVENT and clk = '1' then
      q <= d;
    end if;
  end process;

end a_reg1;