--barrel shift registr pomoci slucovaciho operatoru

library ieee;
use ieee.std_logic_1164.all;

entity barrel is
port (	a: in std_logic_vector(7 downto 0);
	sel: in std_logic_vector(2 downto 0);
	y : out std_logic_vector(7 downto 0)
	);
end barrel;

architecture a_barrel of barrel is
begin

with sel select
	y <= 	a 				when "000",
		a(0) & a(7 downto 1) 		when "001",
		a(1 downto 0) & a(7 downto 2) 	when "010",
		a(2 downto 0) & a(7 downto 3) 	when "011",
		a(3 downto 0) & a(7 downto 4) 	when "100",
		a(4 downto 0) & a(7 downto 5) 	when "101",
		a(5 downto 0) & a(7 downto 6) 	when "110",
		a(6 downto 0) & a(7) 		when others; 	-- 111
	
end a_barrel;