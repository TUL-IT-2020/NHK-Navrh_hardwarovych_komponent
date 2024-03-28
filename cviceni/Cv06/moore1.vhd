-- automat detekujici posloupnosti 111 a 011 (zprava doleva)

library ieee;
use ieee.std_logic_1164.all;

entity moore1 is
	port (clk, vst, reset: in std_logic;
		  y, z : out std_logic);
end moore1;

architecture a_moore1 of moore1 is
	type stav is (S0, S1, S2, S3, S4);
	signal akt_stav, nasl_stav : stav;

begin
	process (clk, reset)
	begin
		if (reset = '1') then
			akt_stav <= S0;
		elsif  clk'event and clk='1' then
			akt_stav <= nasl_stav;
		end if;
	end process;

prech_fce: process (akt_stav, vst)
begin
	case akt_stav is
		when S0 => 
			case vst is
				when '1'    => nasl_stav <= S1;
				when others => nasl_stav <= S0;
			end case;
		when S1 => 
			case vst is
				when '1'    => nasl_stav <= S2;
				when others => nasl_stav <= S0;
			end case;
		when S2 => 
			case vst is
				when '1'    => nasl_stav <= S4;
				when others => nasl_stav <= S3;
			end case;
		when S3 => 
			case vst is
				when '1'    => nasl_stav <= S1;
				when others => nasl_stav <= S0;
			end case;
		when S4 => 
			case vst is
				when '1'    => nasl_stav <= S1;
				when others => nasl_stav <= S0;
			end case;			
		when others => nasl_stav <= S0;
	end case;
end process prech_fce;

vyst_fce: process (akt_stav)
begin
	case akt_stav is
		when S3     => y <= '0'; z <= '1';
		when S4     => y <= '1'; z <= '0';
		when others => y <= '0'; z <= '0';
	end case;
end process vyst_fce;

end a_moore1;
