-- ukazka zapisu tristavove sbernice (pouziti procesu) 

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY h_imp2 IS
	PORT(A,B : IN	STD_LOGIC;
	EnA,EnB	 : IN	STD_LOGIC;
	Y	 : OUT	STD_LOGIC);
END h_imp2;

ARCHITECTURE arch OF h_imp2 IS
BEGIN

PROCESS (A, EnA)
BEGIN
	IF (EnA = '1') THEN
		Y <= A;
	ELSE
		Y <= 'Z';
	END IF;
END PROCESS;

PROCESS (B, EnB)
BEGIN
	IF (EnB = '1') THEN
		Y <= B;
	ELSE
		Y <= 'Z';
	END IF;
END PROCESS;

END arch;