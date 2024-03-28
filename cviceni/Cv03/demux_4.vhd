library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity demux_4 is
  port
  (
    X : in std_logic_vector(3 downto 0);
    A : in std_logic_vector(1 downto 0);
    Y : out std_logic_vector(15 downto 0));
end demux_4;

architecture demux_4 of demux_4 is

begin
  demux : process (X, A)
    variable address      : integer range 0 to 15;
    variable address_high : integer range 0 to 15;
    variable address_low  : integer range 0 to 15;
  begin
    address := to_integer(unsigned(A));
    --address_high := ((address + 1) * 4 - 1);
    --address_low  := (address * 4);
    -- process the input
    Y                                               <= (others => '0');
    Y(((address + 1) * 4 - 1) downto (address * 4)) <= X;
  end process demux;

end demux_4;