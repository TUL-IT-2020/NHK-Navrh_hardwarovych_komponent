--priklad stavoveho automatu typu Mealy

library ieee;
use ieee.std_logic_1164.all;

entity mealy is
	port (clock, reset : in std_logic;
	   data_out : out std_logic;
	   data_in : in std_logic_vector (1 downto 0));
end mealy;

architecture behave of mealy is
	type hodnoty_stavu is (ST0, ST1, ST2, ST3, ST4);
	signal akt_stav, nasl_stav : hodnoty_stavu;
begin
reg: process (clock, reset) 		-- registrova cast
begin
	if (reset = '0') then 
		akt_stav <= ST0;
	elsif (clock'event and clock = '1') then
		akt_stav <= nasl_stav;
	end if;
end process reg;

prech: process (akt_stav, data_in) 	-- prechodova funkce
begin
	case akt_stav is
		when ST0 => 
			case data_in is
				when "00"   => nasl_stav <= ST0;
				when "01"   => nasl_stav <= ST4;
				when "10"   => nasl_stav <= ST1;
				when "11"   => nasl_stav <= ST2;
				when others => nasl_stav <= ST0;
			end case;
		when ST1 => 
			case data_in is
				when "00"   => nasl_stav <= ST0;
				when "10"   => nasl_stav <= ST2;
				when others => nasl_stav <= ST1;
			end case;
		when ST2 => 
			case data_in is
				when "00"   => nasl_stav <= ST1;
				when "01"   => nasl_stav <= ST1;
				when "10"   => nasl_stav <= ST3;
				when "11"   => nasl_stav <= ST3;
				when others => nasl_stav <= ST0;
			end case;
		when ST3 => 
			case data_in is
				when "01"   => nasl_stav <= ST4;
				when "11"   => nasl_stav <= ST4;
				when others => nasl_stav <= ST3;
			end case;
		when ST4 => 
			case data_in is
				when "11"   => nasl_stav <= ST4;
				when others => nasl_stav <= ST0;
			end case;
		when others => nasl_stav <= ST0;
	end case;
end process prech;

vyst: process (akt_stav, data_in)	-- vystupni funkce
begin
	case akt_stav is
		when ST0 =>
			case data_in is
				when "00"   => data_out <= '0';
				when others => data_out <= '1';
			end case;
		when ST1 => data_out <= '0';
		when ST2 =>
			case data_in is
				when "00"   => data_out <= '0';
				when "01"   => data_out <= '0';
				when others => data_out <= '1';
			end case;
		when ST3 => data_out <= '1';
		when ST4 =>
			case data_in is
				when "10"   => data_out <= '1';
				when "11"   => data_out <= '1';
				when others => data_out <= '0';
			end case;
		when others => data_out <= '0';
	end case;
end process vyst;

end behave;
