-- KO typu JK s resetem

library ieee;
use ieee.std_logic_1164.all;

entity JK_FF is
port (	clock	: in std_logic;
	J, K	: in std_logic;
	reset	: in std_logic;
	Q, Qbar	: out std_logic);
end JK_FF;

architecture behv of JK_FF is
    signal state: std_logic;
    signal input: std_logic_vector(1 downto 0);

begin
    input <= J & K;		

    p: process(clock, reset) is
    begin
	
	if (reset='1') then
	    state <= '0';
	elsif (rising_edge(clock)) then
	    case (input) is
		when "11" =>    state <= not state;
		when "10" =>    state <= '1';
		when "01" =>    state <= '0';
		when others =>  state <= state;
	    end case;
	end if;

    end process;
	
    Q <= state;
    Qbar <= not state;

end behv;
