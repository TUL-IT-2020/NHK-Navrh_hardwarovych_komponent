-- dvoumistny dekadicky citac

ENTITY dek_cit_2 IS
	PORT(
	   clk			: IN	bit;
	   segment1, segment2 	: OUT bit_vector(7 downto 0)
	);
END dek_cit_2;

ARCHITECTURE ar OF dek_cit_2 IS
	SIGNAL citac1 : integer range 0 to 9;
	SIGNAL citac2 : integer range 0 to 9;
BEGIN
		
	PROCESS (clk)
	BEGIN
		IF (clk'event and clk = '1') THEN
			citac1 <= citac1 + 1 ;
			IF (citac1 >= 9) THEN
				citac1 <= 0;
				citac2 <= citac2 + 1;
				IF (citac2 >= 9) THEN
					citac2 <= 0;
				END IF;
			END IF;
		END IF;
	END PROCESS;

	PROCESS (citac1) 
	BEGIN
		CASE citac1 IS
			WHEN 0 => segment1 <= "00000011";     
			WHEN 1 => segment1 <= "10011111";
			WHEN 2 => segment1 <= "00100101";
			WHEN 3 => segment1 <= "00001101";
			WHEN 4 => segment1 <= "10011001";
			WHEN 5 => segment1 <= "01001001";
			WHEN 6 => segment1 <= "01000001";
			WHEN 7 => segment1 <= "00011111";
			WHEN 8 => segment1 <= "00000001";
			WHEN 9 => segment1 <= "00001001";
			WHEN others => segment1 <= "11111101";
		END CASE;
	END PROCESS;

	PROCESS (citac2) 
	BEGIN
		CASE citac2 IS
			WHEN 0 => segment2 <= "00000011";     
			WHEN 1 => segment2 <= "10011111";
			WHEN 2 => segment2 <= "00100101";
			WHEN 3 => segment2 <= "00001101";
			WHEN 4 => segment2 <= "10011001";
			WHEN 5 => segment2 <= "01001001";
			WHEN 6 => segment2 <= "01000001";
			WHEN 7 => segment2 <= "00011111";
			WHEN 8 => segment2 <= "00000001";
			WHEN 9 => segment2 <= "00001001";
			WHEN others => segment2 <= "11111101";
	    END CASE;
  END PROCESS;

END ar;

