library ieee;
use ieee.std_logic_1164.all;

entity demux_4 is 
port ( 
	X : in std_logic_vector(15 downto 0);
	A : in integer range 0 to 3;
	Y : out std_logic_vector(3 downto 0));
end demux_4;

architecture cv03_a of demux_4 is
begin

Y <= X(((A+1)*4-1) downto (A*4));

end cv03_a;