-- synchronni FIFO s organizaci 256x8 bitu

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
   port (
      reset  : in std_logic;
      wr_en  : in std_logic;
      wr_clk : in std_logic;
      rd_en  : in std_logic;
      rd_clk : in std_logic;
      din    : in std_logic_vector (7 downto 0);
      dout   : out std_logic_vector (7 downto 0);
      words  : out std_logic_vector (7 downto 0)
   );
end fifo;

architecture model of fifo is
   type mem is array(0 to 255) of std_logic_vector (7 downto 0);
   signal fifo_mem : mem;
   signal fifo_wr_ptr, fifo_rd_ptr : unsigned (7 downto 0);

begin
   -- zapis do FIFO
   process (wr_clk, reset)
   begin
      if reset = '1' then
         fifo_wr_ptr <= (others => '0');
      elsif wr_clk'event and wr_clk = '1' then
         if wr_en = '1' then
            fifo_mem(to_integer(fifo_wr_ptr)) <= din;
            fifo_wr_ptr <= fifo_wr_ptr + 1;
         end if;
      end if;
   end process;

   -- cteni z FIFO
   process (rd_clk, reset)
   begin
      if reset = '1' then
         fifo_rd_ptr <= (others => '0');
      elsif rd_clk'event and rd_clk = '1' then
         if rd_en = '1' then
            dout(7 downto 0) <= fifo_mem(to_integer(fifo_rd_ptr));
            fifo_rd_ptr <= fifo_rd_ptr + 1;
         end if;
      end if;
   end process;

   -- pocet slov ve FIFO
   words <= std_logic_vector (fifo_wr_ptr - fifo_rd_ptr);

end model;
