--citac adres pameti ROM

Library ieee;
Use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.ALL;

Entity cnt4 is
    Port (	
		clk_in	: in std_logic;
		en_in		: in std_logic;
		srst_in 	: in std_logic;			
		cnt4_out	: out std_logic_vector(3 downto 0)			
    );
End cnt4;

Architecture cnt4_a of cnt4 is

	signal s_cnt4 : std_logic_vector(3 downto 0);

Begin
    process(clk_in)
    begin
      if (clk_in'event and clk_in = '1') then
			if (srst_in = '1') then
				s_cnt4 <= (others => '0');
			else
				if (en_in = '1') then
					s_cnt4 <= s_cnt4 + 1;
				end if;				       
			end if;
		end if;
    end process;
    
    cnt4_out <= s_cnt4;

End cnt4_a;
