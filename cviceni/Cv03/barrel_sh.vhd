-- barrel shift registr pomoci rotace

library ieee;
use ieee.numeric_bit.all;

entity barrel_sh is
port(	s : in bit_vector(2 downto 0);
	i : in bit_vector(7 downto 0);
	q : out bit_vector(7 downto 0)
	);
end barrel_sh;

architecture a_bar_sh of barrel_sh is
begin

q <= i rol to_integer(unsigned(s)); 

end a_bar_sh;