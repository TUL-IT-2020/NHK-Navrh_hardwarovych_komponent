-- 4bitovy citac s asynchronnim resetem a synchronni predvolbou

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count16 is
  port
  (
    clk, rst, load : in std_logic;
    data           : in unsigned (3 downto 0);
    count          : out unsigned (3 downto 0)
  );
end count16;

architecture a_count16 of count16 is
begin
  process (rst, clk)
    variable Q : unsigned (3 downto 0);
  begin
    if rst = '1' then
      Q := "0000";
    elsif rising_edge(clk) then
      if load = '1' then
        Q := data;
      elsif Q = 15 then
        Q := "0000";
      else
        Q := Q + "0001";
      end if;
    end if;

    count <= Q;

  end process;

end a_count16;