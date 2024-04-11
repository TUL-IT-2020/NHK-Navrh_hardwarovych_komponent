-- asynchronni pamet RAM s obousmernou datovou sbernici

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_bidir is
   port (
      adr : in std_logic_vector (7 downto 0);
      dio : inout std_logic_vector (7 downto 0);
      cs : in std_logic;
      oe : in std_logic;
      wr : in std_logic
      );
end ram_bidir;

architecture behav of ram_bidir is
   type mem is array (0 to 255) of std_logic_vector (7 downto 0);
   signal ram_block : mem;
begin
   process (wr, dio)
   begin
      if cs = '0' and wr = '0' then
         ram_block(to_integer(unsigned(adr))) <= dio;
      end if;
   end process;

   dio <= ram_block(to_integer(unsigned(adr))) when (cs = '0' and oe = '0')
         else (others => 'Z');
end behav;
