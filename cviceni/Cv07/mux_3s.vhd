-- ukazka pripojeni tristavoveho budice k logice

library ieee;
use ieee.std_logic_1164.all;

entity mux_3s is
  port
  (
    a, b, c, d : in std_logic_vector(3 downto 0);
    s          : in std_logic_vector(1 downto 0);
    oe         : in std_logic;
    x_3s       : out std_logic_vector(3 downto 0));
end mux_3s;

architecture amux_3s of mux_3s is
  signal pom : std_logic_vector(3 downto 0);

begin
  with s select
    pom <= a when "00",
    b when "01",
    c when "10",
    d when others;

  x_3s <= pom when oe = '1' else
    (others => 'Z');

end amux_3s;