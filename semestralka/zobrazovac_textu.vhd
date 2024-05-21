library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SevenSegment_Package.all;

entity zobrazovac_textu is
    generic (
        --CLOCK_FREQUENCY : integer := 50000000; --! Input clock frequenci.
        --DEBOUCE_FREQUENCY : integer := 100;
        --ROTATION_FREQUENCY : integer := 2; 	--! Počet synchronizatorů připojených za tlačítkem.
        -- simulation
        CLOCK_FREQUENCY    : integer := 20;
        DEBOUCE_FREQUENCY  : integer := 10;
        ROTATION_FREQUENCY : integer := 2;
        --
        INIT_STRING        : string  := "Ahoj  "; --! Počáteční text.
        BUTTON_SYNC_LENGTH : integer := 2;
        NUMBER_OF_DIGITS   : integer := 6; --! Počet cislic na desce.
        NUMBER_OF_SEGMENTS : integer := 7; --! Klasický 7-segmentový displej
        COUNTER_WIDTH      : integer := 3  --! 2**COUNTER_WIDTH >= NUMBER_OF_DIGITS
    );
    port (
        -- inputs
        clk    : in std_logic;
        reset  : in std_logic;
        switch : in std_logic;
        -- outputs
        -- array of 6 characters to display
        segments : out std_logic_vector((NUMBER_OF_DIGITS * NUMBER_OF_SEGMENTS) - 1 downto 0);
        -- pro simulaci
        switch_rising_edge_out : out std_logic;
        ROM_address_out        : out integer range 0 to INIT_STRING'length - 1;
        index_shift_out        : out std_logic_vector(COUNTER_WIDTH - 1 downto 0);
        char_out               : out character
    );
end zobrazovac_textu;

architecture Behavioral of zobrazovac_textu is
    -- ROM
    signal ROM_address : integer range 0 to INIT_STRING'length - 1;
    signal ROM_data    : byte;
    -- switch
    signal switch_synct_en    : std_logic;
    signal switch_synct       : std_logic;
    signal switch_rising_edge : std_logic;
    -- index shift counter
    signal index_shift            : std_logic_vector(COUNTER_WIDTH - 1 downto 0) := (others => '0');
    signal counter_up             : std_logic;
    signal counter_down           : std_logic;
    signal counter_en             : std_logic;
    signal shift_counter_en       : std_logic;
    signal shift_enable_generator : std_logic;
    -- 7-segment display
    signal index : std_logic_vector(COUNTER_WIDTH - 1 downto 0); -- TODO: text length
begin
    switch_rising_edge_out <= switch_rising_edge;
    char_out               <= byte_to_character(ROM_data);
    ROM_address_out        <= ROM_address;
    index_shift_out        <= index_shift;

    --! enable generator for shift counter
    Freq_divider_synct : entity work.FrequencyDivider
        generic map(
            CLOCK_FREQUENCY  => CLOCK_FREQUENCY,
            OUTPUT_FREQUENCY => DEBOUCE_FREQUENCY
        )
        port map(
            clk     => clk,
            reset   => reset,
            clk_out => switch_synct_en
        );

    --! enable generator for shift counter
    Freq_divider_rotation : entity work.FrequencyDivider
        generic map(
            CLOCK_FREQUENCY  => CLOCK_FREQUENCY,
            OUTPUT_FREQUENCY => ROTATION_FREQUENCY
        )
        port map(
            clk     => clk,
            reset   => reset,
            clk_out => shift_enable_generator
        );

    --! dvojity synchronizator
    Synchronizer : entity work.Generic_Shift_Register
        generic map(
            WIDTH       => BUTTON_SYNC_LENGTH,
            WITH_ENABLE => true
        )
        port map(
            clk       => clk,
            reset     => reset,
            en        => switch_synct_en,
            shift_in  => switch,
            shift_out => switch_synct
        );

    --! edge detection
    EdgeDetection : entity work.edge_detector
        port map(
            clk    => clk,
            reset  => reset,
            input  => switch_synct,
            output => switch_rising_edge
        );

    --! state machine
    StateMachine : entity work.StateMachine
        port map(
            clk            => clk,
            rst            => reset,
            button_pressed => switch_rising_edge,
            en             => counter_en,
            up             => counter_up,
            down           => counter_down
        );

    shift_counter_en <= counter_en and shift_enable_generator;
    --! index shift counter
    IndexShiftCounter : entity work.UpDownCounter
        generic map(
            WIDTH       => COUNTER_WIDTH,
            ENABLE_INIT => false,
            ENABLE_MAX  => true
        )
        port map(
            clk       => clk,
            reset     => reset,
            enable    => shift_counter_en,
            up        => counter_up,
            init_value => (others => '0'),
            count     => index_shift,
            max_value => to_unsigned(NUMBER_OF_DIGITS - 1, COUNTER_WIDTH)
        );

    --! index shift counter
    IndexCounter : entity work.UpDownCounter
        generic map(
            WIDTH       => COUNTER_WIDTH,
            ENABLE_INIT => false,
            ENABLE_MAX  => true
        )
        port map(
            clk       => clk,
            reset     => reset,
            enable    => switch_synct_en,
            up        => '1',
            init_value => (others => '0'),
            count     => index,
            max_value => to_unsigned(INIT_STRING'length - 1, COUNTER_WIDTH)
        );

    ROM_address <= to_integer(unsigned(index));

    --! inicializace pameti
    ROM : entity work.Memory_file
        generic map(
            INIT_STRING => INIT_STRING
        )
        port map(
            address  => ROM_address,
            data_out => ROM_data
        );

    -- zobrazovaná číslice
    process (clk)
        variable actual_index  : integer range 0 to 5 := 0;
        variable segment_start : integer              := 0;
        variable segment_end   : integer              := 0;
    begin
        if rising_edge(clk) then
            actual_index  := (ROM_address + to_integer(unsigned(index_shift))) mod NUMBER_OF_DIGITS;
            segment_start := actual_index * NUMBER_OF_SEGMENTS;
            segment_end   := segment_start + NUMBER_OF_SEGMENTS - 1;
            segments(segment_end downto segment_start) <= (not convert_char_to_7seg(ROM_data)) & '0';
        end if;
    end process;
end Behavioral;