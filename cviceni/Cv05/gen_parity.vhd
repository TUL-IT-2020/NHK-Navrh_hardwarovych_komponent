-- generator parity

library IEEE;
use IEEE.std_logic_1164.all;

entity gen_parity is
  generic
    (n : positive);
  port
  (
    x : in std_logic_vector(n - 1 downto 0);
    y : out std_logic
  );
end gen_parity;

architecture arch of gen_parity is
begin

  process (x)
    variable temp : std_logic;
  begin
    temp := '0';
    for i in x'range loop
      temp := temp xor x(i);
    end loop;

    y <= temp;

  end process;

end arch;