--ukazka dvouhranoveho klopneho obvodu

library ieee; 
use ieee.std_logic_1164.all;

entity dual_edge is
port(
	rst	: in std_logic;
	clk 	: in std_logic;
	D 	: in std_logic;
	Q 	: out std_logic
	);
end dual_edge;

architecture a_dual_edge of dual_edge is
signal QRISE : std_logic;
signal QFALL : std_logic;
begin

rising:process(rst, clk)
begin
	if rst = '1' then
		QRISE <= '0';
	elsif clk'event and clk = '1' then
		QRISE <= D;
	end if;
end process rising;

falling:process(rst, clk)
begin
	if rst = '1' then
		QFALL <='0';
	elsif clk'event and clk = '0' then
		QFALL <= D;
	end if;
end process falling;

Q <= QRISE when clk = '1' else QFALL;

end a_dual_edge;