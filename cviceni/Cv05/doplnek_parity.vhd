-- vyuziti generatoru parity jako komponenty

library IEEE;
use IEEE.std_logic_1164.all;

entity doplnek_parity is
  generic
    (n : integer := 7);
  port
  (
    vst  : in std_logic_vector(n - 1 downto 0);
    vyst : out std_logic_vector(n downto 0)
  );
end doplnek_parity;

architecture arch of doplnek_parity is
  component gen_parity is
    generic
      (n : positive);
    port
    (
      x : in std_logic_vector(n - 1 downto 0);
      y : out std_logic
    );
  end component;

begin
  comp1 : gen_parity generic
  map (n) port map
  (vst, vyst(n));
  vyst (n - 1 downto 0) <= vst;
end arch;