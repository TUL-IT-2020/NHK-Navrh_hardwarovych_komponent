-- pamet ROM 8x4 vytvorena uzitim pole konstant

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY rom2 IS PORT (
		address : IN std_logic_vector(2 DOWNTO 0);
		output : OUT std_logic_vector(3 DOWNTO 0));
END rom2;

ARCHITECTURE a_rtl_rom2 OF rom2 IS
	CONSTANT num_word : integer := 8;
	CONSTANT num_bit  : integer := 4;
	TYPE romarray IS ARRAY (0 TO (num_word-1)) OF std_logic_vector((num_bit-1) DOWNTO 0);
	CONSTANT rom : romarray := ("0001","0010","0100","1000","1000","0100","0010","0001");			

BEGIN
	output  <= rom(CONV_INTEGER(address));
END a_rtl_rom2;
