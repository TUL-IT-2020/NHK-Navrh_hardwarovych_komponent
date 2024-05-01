library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

--! Frekvencni delic <br>
--! Podle zadane frekvence na vstupu a na vystupu vytvori frekvencni delic.
entity FrequencyDivider is
    generic
    (
        CLOCK_FREQUENCY  : integer := 50000000; --! Frekvence vstupního hodinového signálu (v Hz)
        OUTPUT_FREQUENCY : integer := 1000 --! Požadovaná frekvence na výstupu (v Hz)
    );
    port
    (
        clk     : in std_logic;
        reset   : in std_logic;
        clk_out : out std_logic --! Output clock signal
    );
end entity FrequencyDivider;

architecture Behavioral of FrequencyDivider is
    constant PERIOD : integer                                                  := CLOCK_FREQUENCY / OUTPUT_FREQUENCY; --! Perioda vstupního signálu
    signal clk_div  : std_logic                                                := '0'; --! Dělený hodinový signál
    signal counter  : unsigned(integer(ceil(log2(real(PERIOD - 1)))) downto 0) := (others => '0'); --! Čítač pro vytvoření střídy
begin
    -- Generování děleného hodinového signálu
    counting : process (clk)
        variable prescaler : integer := 0; -- Počítadlo pro dělení vstupního signálu
    begin
        if rising_edge(clk) then
            if prescaler < PERIOD - 1 then
                prescaler := prescaler + 1; -- Inkrementace počítadla
            else
                prescaler := 0;
                clk_div <= not clk_div; -- Invertování hodnoty děleného hodinového signálu
            end if;
        end if;
    end process;

    clk_out <= clk_div; -- Připojení děleného hodinového signálu na výstup

end architecture Behavioral;