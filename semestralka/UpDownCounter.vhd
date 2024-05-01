-- Generický up-down čítač s výchozí hodnotou
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UpDownCounter is
    generic
    (
        WIDTH       : integer := 8; --! Width of the counter
        ENABLE_INIT : boolean := true; --! After reset, the counter is set to init_value
        ENABLE_MAX  : boolean := true --! After reaching the maximum value, the counter is reset to zero
    );
    port
    (
        clk        : in std_logic;
        reset      : in std_logic;
        enable     : in std_logic; --! Enable counting
        up         : in std_logic; --! Direction of counting (up = '1', down = '0')
        init_value : in unsigned(WIDTH - 1 downto 0); --! Initial value of the counter after reset
        max_value  : in unsigned(WIDTH - 1 downto 0); --! Maximum value of the counter
        count      : out std_logic_vector(WIDTH - 1 downto 0) --! Current value of the counter
    );
end entity UpDownCounter;

architecture Behavioral of UpDownCounter is
    signal counter_reg         : unsigned(WIDTH - 1 downto 0);
    signal internal_init_value : unsigned(WIDTH - 1 downto 0);
begin
    process (init_value)
    begin
        if ENABLE_INIT then
            internal_init_value <= init_value;
        else
            internal_init_value <= (others => '0');
        end if;
    end process;

    process (clk, reset)
    begin
        if reset = '1' then
            counter_reg <= internal_init_value;
        elsif rising_edge(clk) then
            if enable = '1' then -- Pokud je povolení aktivní
                if up = '0' then
                    counter_reg <= counter_reg - 1; -- Dekrementace čítače při aktivním signálu dolů
                elsif up = '1' then
                    counter_reg <= counter_reg + 1; -- Inkrementace čítače, pokud je signál dolů neaktivní
                end if;
                if ENABLE_MAX then
                    if counter_reg > max_value then -- Pokud je dosaženo maximální hodnoty
                        counter_reg <= internal_init_value;
                    end if;
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(counter_reg);
end architecture Behavioral;