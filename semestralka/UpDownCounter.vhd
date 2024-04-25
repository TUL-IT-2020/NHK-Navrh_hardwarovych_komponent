-- Generický up-down čítač s výchozí hodnotou
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UpDownCounter is
    generic (
        WIDTH : integer := 8  -- Šířka čítače
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        up : in std_logic;
        init_value : in unsigned(WIDTH - 1 downto 0);
        count : out std_logic_vector(WIDTH - 1 downto 0)
    );
end entity UpDownCounter;

architecture Behavioral of UpDownCounter is
    signal counter_reg : unsigned(WIDTH - 1 downto 0);
begin
    process (clk, reset)
    begin
        if reset = '1' then
            counter_reg <= init_value;  -- Resetovat čítač na hodnotu init_value
        elsif rising_edge(clk) then
            if enable = '1' then  -- Pokud je povolení aktivní
                if up = '0' then
                    counter_reg <= counter_reg - 1;  -- Dekrementace čítače při aktivním signálu dolů
                elsif up = '1' then
                    counter_reg <= counter_reg + 1;  -- Inkrementace čítače, pokud je signál dolů neaktivní
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(counter_reg);  -- Převést unsigned na std_logic_vector
end architecture Behavioral;
