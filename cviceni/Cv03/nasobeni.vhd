-- nasobicka

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nasobeni is
  port
  (
    operand : in unsigned(2 downto 0);
    soucin  : out unsigned(5 downto 0)
  );
end nasobeni;

architecture rtl of nasobeni is
  constant dvojka : unsigned(2 downto 0) := "101";
begin
  soucin <= dvojka * operand;
end rtl;