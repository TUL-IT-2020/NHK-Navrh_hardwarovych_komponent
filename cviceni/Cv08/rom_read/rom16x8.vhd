--pamet ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rom16x8 is 
	port (
		address	: in std_logic_vector(3 downto 0);
		outp		: out std_logic_vector(7 downto 0)
		);
end rom16x8;

architecture a_rtl_rom of rom16x8 is
	constant num_word : integer := 16;
	constant num_bit  : integer := 8;
	type romarray is array (0 to (num_word-1)) of std_logic_vector((num_bit-1) downto 0);
	constant rom : romarray := (X"0F",X"0E",X"0D",X"0C",X"0B",X"0A",X"09",X"08",X"07",X"06",X"05",X"04",X"03",X"02",X"01",X"00");			

begin
	outp <= rom(conv_integer(address));
end a_rtl_rom;