--vyuziti procedury definovane v package

library IEEE;
use IEEE.std_logic_1164.all;

use work.decProcs.all;

entity dec2x4pr is port (
  decIn: in std_logic_vector(1 downto 0);
  decOut: out std_logic_vector(3 downto 0)
  );
end dec2x4pr;

architecture simple of dec2x4pr is

begin

  DEC2x4(decIn,decOut);

end simple;

