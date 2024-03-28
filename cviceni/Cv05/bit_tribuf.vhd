-- jednobitovy 3stavovy budic

library ieee;
use ieee.std_logic_1164.all;

entity bit_tribuf is
  port
  (
    Din    : in bit;
    Enable : in bit;
    Dout   : out std_logic
  );
end bit_tribuf;

architecture bit_tribuf_arch of bit_tribuf is

begin

  Dout <= to_stdlogic(Din) when Enable = '1' else
    'Z';

end bit_tribuf_arch;