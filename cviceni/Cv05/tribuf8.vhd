-- osmibitovy 3stavovy 8bitovy budic

library ieee;
use ieee.std_logic_1164.all;

entity tribuf8 is
  port (
    Din    : in  bit_vector(7 downto 0);
    Enable : in  bit;
    Dout   : out std_logic_vector(7 downto 0));
end tribuf8;

architecture tribuf8_arch of tribuf8 is
component bit_tribuf 
    port (
	Din : in bit;
	Enable: in bit;
	Dout : out std_logic
	);
end component;

begin 

all_buf: for i in 7 downto 0 generate
    one_buf: bit_tribuf port map (
      Din    => Din(i),
      Enable => Enable,
      Dout   => Dout(i));
  end generate all_buf;

end tribuf8_arch;
