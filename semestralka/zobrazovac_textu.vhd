library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SevenSegment_Package.all;

entity zobrazovac_textu is
    generic (
        NUMBER_OF_DIGITS : integer := 6;
        NUMBER_OF_SEGMENTS : integer := 7
    );
    port(
        -- inputs
        clk : in std_logic;
        reset : in std_logic;
        switch : in std_logic;
        -- outputs
        -- array of 6 characters to display
        segments : out std_logic_vector((NUMBER_OF_DIGITS * NUMBER_OF_SEGMENTS) - 1 downto 0)
    );
end zobrazovac_textu;

architecture Behavioral of zobrazovac_textu is
    signal ROM_address : integer range 0 to NUMBER_OF_DIGITS-1 := 0;
    signal ROM_data : byte;
begin
    -- inicializace pameti
    ROM : entity work.Memory_file 
    generic (
        INIT_STRING : string := "Ahoj  "
    ); 
    port map (
        address => ROM_address,
        data_out => ROM_data
    );
    end entity;

    -- zobrazeni textu
    process(clk, reset)
    begin
        if reset = '1' then
            ROM_address <= 0;
            segments <= (others => '0');
        elsif rising_edge(clk) then
            if switch = '1' then
                segments(0 to 6) <= convert_char_to_7seg(ROM_data);
            end if;
        end if;
    end process;

end Behavioral;
