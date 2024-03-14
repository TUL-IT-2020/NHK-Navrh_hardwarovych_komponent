-- Parametrizovatelny dvousmerny posuvny registr

library ieee;
use ieee.std_logic_1164.all;

entity posuv_reg_bi is
  generic
  (
    n : positive := 8
  );
  port
  (
    clk : in std_logic;
    dir : in std_logic;
    sdl : in std_logic;
    sdr : in std_logic;
    q   : out std_logic_vector (1 to n)
  );
end posuv_reg_bi;

architecture struct of posuv_reg_bi is
  signal reg : std_logic_vector (1 to n);
begin
  -- realizace dvojsmerneho posuvneho registru
  process (clk)
  begin
    if clk'event and clk = '1' then
      if dir = '1' then
        reg <= sdl & reg (1 to n - 1);
      else
        reg <= reg (2 to n) & sdr;
      end if;
    end if;
  end process;
  q <= reg;
end struct;