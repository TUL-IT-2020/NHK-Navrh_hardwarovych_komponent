library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SevenSegment_Package.all;

entity zobrazovac_textu is
    generic (
        CLOCK_FREQUENCY : integer := 50000000;
        DEBOUCE_FREQUENCY : integer := 100;
        ROTATION_FREQUENCY : integer := 1;
        BUTTON_SYNC_LENGTH : integer := 2;
        NUMBER_OF_DIGITS : integer := 6;
        NUMBER_OF_SEGMENTS : integer := 7;
        COUNTER_WIDTH : integer := 3
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
    -- ROM
    signal ROM_address : integer range 0 to NUMBER_OF_DIGITS-1 := 0;
    signal ROM_data : byte;
    -- switch
    signal switch_synct_en : std_logic;
    signal switch_synct : std_logic;
    signal switch_rising_edge : std_logic;
    -- index shift counter
    signal index_shift : std_logic_vector(COUNTER_WIDTH-1 downto 0) := (others => '0');
    signal counter_up : std_logic;
    signal counter_down : std_logic;
    signal counter_en : std_logic;
    signal shift_counter_en : std_logic;
    signal shift_enable_generator : std_logic;
    -- 7-segment display
begin

    -- enable generator for shift counter
    Freq_divider_synct : entity work.FrequencyDivider
    generic map (
        CLOCK_FREQUENCY => CLOCK_FREQUENCY,
        OUTPUT_FREQUENCY => DEBOUCE_FREQUENCY
    )
    port map(
        clk => clk,
        reset => reset,
        clk_out => switch_synct_en
    );

    -- enable generator for shift counter
    Freq_divider_synct : entity work.FrequencyDivider
    generic map (
        CLOCK_FREQUENCY => CLOCK_FREQUENCY,
        OUTPUT_FREQUENCY => DEBOUCE_FREQUENCY
    )
    port map(
        clk => clk,
        reset => reset,
        clk_out => shift_enable_generator
    );

    -- dvojity synchronizator
    Synchronizer : entity work.Generic_Shift_Register
    generic map (
        NUMBER_OF_BITS => BUTTON_SYNC_LENGTH,
        WITH_ENABLE => true
    )
    port map(
        clk => clk,
        reset => reset,
        en => switch_synct_en,
        data_in => switch,
        data_out => switch_synct
    );

    -- edge detection
    EdgeDetection : entity work.edge_detector
    port map(
        clk => clk,
        reset => reset,
        input => switch_synct,
        output => switch_rising_edge
    );

    -- state machine
    StateMachine : entity work.StateMachine
    port map (
        clk => clk,
        rst => reset,
        button_pressed => switch_rising_edge,
        en => counter_en,
        up => counter_up,
        down => counter_down
    );

    shift_counter_en <= counter_en and shift_enable_generator;
    -- index shift counter
    IndexShiftCounter : entity work.UpDownCounter
    generic map (
        COUNTER_WIDTH => 3,
        ENABLE_INIT => false,
        ENABLE_MAX => true
    )
    port map (
        clk => clk,
        reset => reset,
        enable => shift_counter_en,
        up => counter_up,
        count => index_shift,
        max_value => NUMBER_OF_DIGITS-1
    );

    -- inicializace pameti
    ROM : entity work.Memory_file 
    generic map (
        INIT_STRING =>  "Ahoj  "
    )
    port map(
        address => ROM_address,
        data_out => ROM_data
    );

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
