-- Synchronni klopny obvod typu T s asynchr. resetem

library ieee;
use ieee.std_logic_1164.all;

entity t_ff is
   port (
      t : in std_logic;
      r : in std_logic;
      clk : in std_logic;
      q : out std_logic;
      n_q : out std_logic
   );
end t_ff;

architecture struct of t_ff is
begin
   process (clk, r)
      variable ff : std_logic;
   begin
      if r = '1' then
         ff := '0';
      elsif clk'event and clk = '1' then
         if t = '1' then
            ff := not ff;
         end if;
      end if;
      q <= ff;
      n_q <= not ff;
   end process;
end struct;
