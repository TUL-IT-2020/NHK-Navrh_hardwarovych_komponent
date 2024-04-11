-- asynchronni pamet RAM s organizaci 256x8 bitu

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_async is
   port (
      adr : in std_logic_vector (7 downto 0);
      di : in std_logic_vector (7 downto 0);
      cs : in std_logic;
      oe : in std_logic;
      wr : in std_logic;
      do : out std_logic_vector (7 downto 0)
   );
end ram_async;

architecture behav of ram_async is
   type mem is array (0 to 255) of std_logic_vector (7 downto 0);
   signal ram_block : mem;
begin
   -- zapis do ram (pouze pri aktivnim cs a wr)
   process (wr, di)
   begin
      if cs = '0' and wr = '0' then
         ram_block(to_integer(unsigned(adr))) <= di;
      end if;
   end process;

   -- cteni probiha pri aktivnim cs a oe, jinak dava na vysokou impedanci
   do <= ram_block(to_integer(unsigned(adr))) when (cs = '0' and oe = '0')
         else (others => 'Z');
end behav;
