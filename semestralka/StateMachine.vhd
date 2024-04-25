library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
    port (
        clk : in std_logic;
        rst : in std_logic;
        button_pressed : in std_logic;
        en : out std_logic;
        up : out std_logic;
        down : out std_logic
    );
end entity StateMachine;

architecture Behavioral of StateMachine is
    -- Definice stavů
    type state_type is (RESET, LEFT, STOP_LEFT, RIGHT, STOP_RIGHT);
    signal current_state, next_state : state_type;

begin
    -- Proces řízení stavového automatu
    process (clk, rst, button_pressed)
    begin
        if rst = '1' then
            current_state <= RESET;  -- Inicializace stavového automatu
        elsif rising_edge(clk) then
            -- Přechody mezi stavy
            current_state <= next_state;
        end if;
    end process;

    -- Logika pro přechody mezi stavy
    process (current_state, button_pressed)
    begin
        case current_state is
            when RESET =>
                if button_pressed = '1' then
                    next_state <= LEFT;
                else
                    next_state <= RESET;
                end if;
            when LEFT =>
                if button_pressed = '1' then
                    next_state <= STOP_LEFT;
                else
                    next_state <= LEFT;
                end if;
            when STOP_LEFT =>
                if button_pressed = '1' then
                    next_state <= RIGHT;
                else
                    next_state <= STOP_LEFT;
                end if;
            when RIGHT =>
                if button_pressed = '1' then
                    next_state <= STOP_RIGHT;
                else
                    next_state <= RIGHT;
                end if;
            when STOP_RIGHT =>
                if button_pressed = '1' then
                    next_state <= LEFT;
                else
                    next_state <= STOP_RIGHT;
                end if;
            when others =>
                next_state <= RESET;
        end case;
    end process;

    -- Logika pro nastavení výstupů podle aktuálního stavu
    process (current_state)
    begin
        case current_state is
            when RESET =>
                en <= '0';
                up <= '0';
                down <= '0';
            when LEFT =>
                en <= '1';
                up <= '0';
                down <= '1';
            when STOP_LEFT =>
                en <= '0';
                up <= '0';
                down <= '0';
            when RIGHT =>
                en <= '1';
                up <= '1';
                down <= '0';
            when STOP_RIGHT =>
                en <= '0';
                up <= '0';
                down <= '0';
            when others =>
                en <= '0';
                up <= '0';
                down <= '0';
        end case;
    end process;

end architecture Behavioral;
