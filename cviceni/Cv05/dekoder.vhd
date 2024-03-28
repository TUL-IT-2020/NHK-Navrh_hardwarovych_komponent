-- dekoder "3" na "8" s enablem
-- vstup urcuje, na kterem vystupu bude '0', jinak je vsude '1'

library ieee;
use ieee.std_logic_1164.all;

entity dekoder is
port (
	en  : in std_logic;
	sel : in std_logic_vector(2 downto 0);
	q   : out std_logic_vector(7 downto 0)
	);
end dekoder;

architecture a_dekoder of dekoder is
begin
   process (en, sel)
      variable temp1 : std_logic_vector(q'high downto 0);
      variable temp2 : integer range 0 to q'high;

   begin
      temp1 := (others => '1');
      temp2 := 0;
   if (en = '1') then

      for i in sel'range loop   -- range je (2 downto 0)
         if (sel(i) = '1') then -- prevod z binarniho cisla na integer
            temp2 := 2*temp2+1; 
         else
            temp2 := 2*temp2;
         end if;
      end loop;

      temp1(temp2) := '0';

   end if;

      q <= temp1;

   end process;
end a_dekoder;