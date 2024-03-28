-- automat detekujici posloupnosti 111 a 011 (zprava doleva)

library ieee;
use ieee.std_logic_1164.all;

entity mealy1 is
	port (clk, vst, reset: in std_logic;
		  y, z : out std_logic);
end mealy1;

architecture a_mealy1 of mealy1 is
	type stav is (ST0, ST1, ST2);
	signal akt_stav, nasl_stav : stav;

begin
	process (clk, reset)
	begin
		if (reset = '1') then
			akt_stav <= ST0;
		elsif  clk'event and clk='1' then
			akt_stav <= nasl_stav;
		end if;
	end process;

prech_fce: process (akt_stav, vst)
begin
	case akt_stav is
		when ST0 => 
			case vst is
				when '1'    => nasl_stav <= ST1;
				when others => nasl_stav <= ST0;
			end case;
		when ST1 => 
			case vst is
				when '1'    => nasl_stav <= ST2;
				when others => nasl_stav <= ST0;
			end case;
		when others => nasl_stav <= ST0;
	end case;
end process prech_fce;

vyst_fce: process (akt_stav, vst)
begin
	case akt_stav is
		when ST2 =>
			case vst is
				when '0'    => y <= '0'; z <= '1';
				when others => y <= '1'; z <= '0';
			end case;
		when others => y <= '0'; z <= '0';
	end case;
end process vyst_fce;

end a_mealy1;
