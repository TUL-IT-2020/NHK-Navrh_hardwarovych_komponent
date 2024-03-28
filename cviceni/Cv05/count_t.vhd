-- dvoubitovy asynchronni citac z KO typu T
-- sestaven ze dvou KO T_FF

library ieee;
use ieee.std_logic_1164.all;

entity count_t is
	port(
		clk		: in	std_logic;
		res		: in	std_logic;
		q		: out	std_logic_vector(1 downto 0);
		n_q		: buffer	std_logic_vector(1 downto 0)
		);
end count_t;

architecture a_count_t of count_t is

begin
	T1	: entity work.t_ff port map (t => '1', r => res, clk => clk, 
			q => q(0), n_q => n_q(0));
	T2	: entity work.t_ff port map (t => '1', r => res, clk => n_q(0), 
			q => q(1), n_q => n_q(1));
end a_count_t;

