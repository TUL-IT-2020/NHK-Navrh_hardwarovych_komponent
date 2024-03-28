-- Pocitadlo jednickovych bitu ve vstupnim vektoru

library ieee;
use ieee.std_logic_1164.all;

entity poc_jedn is
  port
  (
    data  : in std_logic_vector (7 downto 0);
    pocet : out integer range 0 to 8
  );
end poc_jedn;

architecture struct of poc_jedn is
begin
  bit_counter process (data)
  variable poc_bitu : integer range 0 to 8;
begin
  poc_bitu := 0;

  for i in data'range loop
    if (data(i) = '1') then
      poc_bitu := poc_bitu + 1;
    end if;
  end loop;

  pocet <= poc_bitu;

end process bit_counter;

end struct;