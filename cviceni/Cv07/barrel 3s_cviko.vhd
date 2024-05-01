-- 8bitovy Barrel shift registr

library ieee;
use ieee.std_logic_1164.all;

entity barrel is
  generic
  (
    WIDTH : integer := 8
  );
  port
  (
    input      : in std_logic_vector(WIDTH - 1 downto 0);
    shift      : in std_logic;
    output_3s  : out std_logic_vector(WIDTH - 1 downto 0);
    out_enable : in std_logic
  );
end barrel;

architecture behavior of barrel is
  signal output : std_logic_vector(WIDTH - 1 downto 0);
begin
  process (input, shift)
  begin
    if (shift = '0') then
      output <= input;
    else
      output(0) <= '0';
      for i in 1 to input'high loop
        output(i) <= input(i - 1);
      end loop;
    end if;
  end process;

  output_3s <= output when out_enable = '1' else
    (others => 'Z');

end behavior;