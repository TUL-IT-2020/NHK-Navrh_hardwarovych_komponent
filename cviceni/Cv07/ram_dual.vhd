-- dvojbranova synchronni pamet RAM s jednou branou pro zapis a druhou pro cteni

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_dual is
   port (
      clock_wr, clock_rd : in std_logic;
      data_in : in std_logic_vector (7 downto 0);
      write_address, read_address : in std_logic_vector (7 downto 0);
      we : in std_logic;
      data_out : out std_logic_vector (7 downto 0)
   );
end ram_dual;

architecture a_ram_dual of ram_dual is
   type mem is array(0 to 255) of std_logic_vector (7 downto 0);
   signal ram_block : mem;
   signal read_address_reg : std_logic_vector (7 downto 0);
begin
   -- zapis do RAM
   process (clock_wr)
   begin
      if clock_wr'event and clock_wr = '1' then
         if we = '1' then
            ram_block(to_integer(unsigned(write_address))) <= data_in;
         end if;
      end if;
   end process;

   -- cteni z RAM
   process (clock_rd)
   begin
      if clock_rd'event and clock_rd = '1' then
         read_address_reg <= read_address;
      end if;
   end process;

   -- data z ram jsou ctena z adresy ulozene v registru
   data_out <= ram_block(to_integer(unsigned(read_address_reg)));
end a_ram_dual;
