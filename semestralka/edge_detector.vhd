-- Kdyz se zmeni signal do "1" tak po prichodu hodin se na jeden takt vygeneruje signal "1" na vystup

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_detector is
    port (
        clk : in std_logic;
        reset : in std_logic;
        signal_in : in std_logic;
        signal_out : out std_logic
    );
end entity edge_detector;

architecture behave of edge_detector is
    type state_type is (ONE, WAIT_FOR_ZERO, WAIT_FOR_ONE);
    signal state : state_type := WAIT_FOR_ONE;
    signal next_state : state_type;
begin
    -- Proces, ktery prejde do noveho stavu
    process(clk)
    begin
        if reset = '1' then
            state <= WAIT_FOR_ONE;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Proces, ktery urcuje dalsi stav
    process(signal_in, state)
    begin
        case state is
            when WAIT_FOR_ONE =>
                case signal_in is
                    when '0' =>
                        next_state <= WAIT_FOR_ONE;
                    when '1' =>
                        next_state <= ONE;
                end case;
            when ONE =>
                case signal_in is
                    when '0' =>
                        next_state <= WAIT_FOR_ONE;
                    when '1' =>
                        next_state <= WAIT_FOR_ZERO;
                end case;
            when WAIT_FOR_ZERO =>
                case signal_in is
                    when '0' =>
                        next_state <= WAIT_FOR_ONE;
                    when '1' =>
                        next_state <= WAIT_FOR_ZERO;
                end case;
            when others =>
                next_state <= WAIT_FOR_ONE;
        end case;
    end process;

    -- Vystupni signal
    signal_out <= '1' when state = ONE else '0';
end architecture behave;
