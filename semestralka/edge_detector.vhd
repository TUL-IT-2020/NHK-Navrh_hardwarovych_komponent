-- Kdyz se zmeni signal do "1" tak po prichodu hodin se na jeden takt vygeneruje signal "1" na vystup

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Edge detector <br>
--! Generate one tick signal when input changes to "1".

entity edge_detector is
    port (
        clk : in std_logic;
        reset : in std_logic;   --! Reset to initial state of "WAIT_FOR_ONE"
        input : in std_logic;   --! Input signal
        output : out std_logic  --! Generate one tick signal when input changes to "1"
    );
end entity edge_detector;

architecture behave of edge_detector is
    type state_type is (ONE, WAIT_FOR_ZERO, WAIT_FOR_ONE);
    signal state : state_type := WAIT_FOR_ONE;
    signal next_state : state_type;
begin
    -- Proces, ktery prejde do noveho stavu
    update_state : process(clk)
    begin
        if reset = '1' then
            state <= WAIT_FOR_ONE;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Proces, ktery urcuje dalsi stav
    state_machine : process(input, state)
    begin
        case state is
            when WAIT_FOR_ONE =>
                case input is
                    when '0' =>
                        next_state <= WAIT_FOR_ONE;
                    when '1' =>
                        next_state <= ONE;
                    when others =>
                        next_state <= WAIT_FOR_ONE;
                end case;
            when ONE =>
                case input is
                    when '0' =>
                        next_state <= WAIT_FOR_ONE;
                    when '1' =>
                        next_state <= WAIT_FOR_ZERO;
                    when others =>
                        next_state <= WAIT_FOR_ONE;
                end case;
            when WAIT_FOR_ZERO =>
                case input is
                    when '0' =>
                        next_state <= WAIT_FOR_ONE;
                    when '1' =>
                        next_state <= WAIT_FOR_ZERO;
                    when others =>
                        next_state <= WAIT_FOR_ONE;
                end case;
            when others =>
                next_state <= WAIT_FOR_ONE;
        end case;
    end process;

    -- Vystupni signal
    output <= '1' when state = ONE else '0';
end architecture behave;
