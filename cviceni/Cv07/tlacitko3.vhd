-- citani poctu stisku tlacitka

ENTITY tlacitko3 IS
	PORT(
		tlac, reset			: IN bit;
		krystal				: IN bit; -- 50 MHz
		segment1, segment2 	: OUT bit_vector(7 downto 0));
END tlacitko3;

ARCHITECTURE ar OF tlacitko3 IS
	SIGNAL delic : integer range 0 to 249999;
	SIGNAL clock : bit;
	SIGNAL tlac1 : bit;
	SIGNAL citac1 : integer range 0 to 9;
	SIGNAL citac2 : integer range 0 to 9;
	
	TYPE states IS (S0, S1, S2);
	SIGNAL state : states := S0;
	SIGNAL nxt_state : states := S0;
	SIGNAL en : bit;

BEGIN
-- vydeleni krystalu na 100 Hz (signal clock)	
PROCESS (krystal)
BEGIN
	IF (krystal'event and krystal = '1') THEN
		delic <= delic+1;
		IF delic = 249999 THEN
			delic <= 0;
			clock <= not clock;
		END IF;
	END IF;
END PROCESS;

-- stavovy automat pro enable citace	
clkd: PROCESS (clock, reset)
BEGIN
	IF (reset = '0') THEN
    	state <= S0;
	ELSIF (clock'EVENT AND clock = '1') THEN
    	state <= nxt_state;
	END IF;
END PROCESS clkd;

state_trans: PROCESS (state, tlac)
BEGIN
	CASE state IS
		WHEN S0 => 	IF (tlac = '1') THEN nxt_state <= S1;
					ELSE nxt_state <= S0;
					END IF;
		WHEN S1 =>	IF (tlac = '1') THEN nxt_state <= S2;
					ELSE nxt_state <= S0;
					END IF;
		WHEN S2 =>	IF (tlac = '1') THEN nxt_state <= S2;
					ELSE nxt_state <= S0;
					END IF;			
	END CASE;
END PROCESS state_trans;

output: PROCESS (state)
BEGIN
	CASE state IS
		WHEN s1 => en <= '1';
		WHEN OTHERS => en <= '0';
	END CASE;
END PROCESS output;
	
-- dvoumistny citac s dekodery
PROCESS (clock, reset)
BEGIN
	IF reset = '0' THEN
		citac1 <= 0; citac2 <= 0;
	ELSIF (clock'event and clock = '1') THEN
		IF en = '1' THEN
			citac1 <= citac1 + 1 ;
			IF (citac1 >= 9) THEN
				citac1 <= 0;
				citac2 <= citac2 + 1;
				IF (citac2 >= 9) THEN
					citac2 <= 0;
				END IF;
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