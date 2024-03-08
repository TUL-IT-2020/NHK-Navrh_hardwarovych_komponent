-- kombinacni funkce zadana pravdivostni tabulkou

entity logika is
  port (vstup : in  bit_vector (2 downto 0);
            y : out bit);
end logika;

architecture a_logika of logika is
begin 

   with vstup select
	y <= '1' when "000",
	     '0' when "001" | "010" | "011",
	     '1' when "100" to "111";

-- jine moznosti zadani
-- y <= '1' when (vstup(0) ='0' and vstup(1) ='0') or (vstup(2) ='1') else '0';
-- y <= (vstup(2) or (not vstup(0) and not vstup(1)));
		  
end a_logika;
