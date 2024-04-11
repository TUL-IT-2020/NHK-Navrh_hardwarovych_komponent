-- ukazka zapisu tristavove sbernice 

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY h_imp1 IS
	PORT(A,B : IN	STD_LOGIC;
	EnA,EnB	 : IN	STD_LOGIC;
	Y	 : OUT	STD_LOGIC);
END h_imp1;

ARCHITECTURE arch OF h_imp1 IS
BEGIN
Y <= A when (EnA = '1') else 'Z';
Y <= B when (EnB = '1') else 'Z';
END arch;