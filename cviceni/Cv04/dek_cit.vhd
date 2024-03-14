-- ukazka dvou "dekadickych" citacu

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY dek_cit IS
	PORT(
	   clk		: IN	std_logic;
	   citac1	: OUT std_logic_vector(3 downto 0); 
		citac2 	: OUT std_logic_vector(3 downto 0)
		);
END dek_cit;

ARCHITECTURE ar_cnt OF dek_cit IS
	SIGNAL cnt1 : unsigned(3 downto 0);
	
BEGIN
		
	PROCESS (clk)
	BEGIN
		IF (clk'event and clk = '1') THEN
		cnt1 <= cnt1 + 1 ;
			IF (cnt1 >= 9) THEN
				cnt1 <= (others => '0');
			END IF;
		END IF;
		citac1 <= std_logic_vector(cnt1);
	END PROCESS;

	PROCESS (clk)
	variable cnt2 : unsigned(3 downto 0);
	BEGIN
		IF (clk'event and clk = '1') THEN
		cnt2 := cnt2 + 1 ;
			IF (cnt2 >= 9) THEN
				cnt2 := (others => '0');
			END IF;
		END IF;
		citac2 <= std_logic_vector(cnt2);
	END PROCESS;
	
END ar_cnt;

