-- scitacka s prenosem

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity overflow is 
   port (
        a,b: in std_logic_vector(3 downto 0);
        sum: out std_logic_vector(3 downto 0);
        overflow: out std_logic 
        );
end overflow;

architecture a of overflow is
signal localSum: std_logic_vector(4 downto 0);

begin

  localSum <= ('0' & a) + ('0' & b);
  sum <= localSum(3 downto 0);
  overflow <= localSum(4);

end a;
