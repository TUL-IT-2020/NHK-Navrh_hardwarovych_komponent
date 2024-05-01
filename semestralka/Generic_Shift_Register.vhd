library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Generic Shift Register

entity Generic_Shift_Register is
    generic
    (
        WIDTH       : integer := 8; --! Width of the shift register
        WITH_ENABLE : boolean := false --! Enable signal for the shift register
    );
    port
    (
        clk       : in std_logic; --! Clock signal
        reset     : in std_logic; --! Reset the internal state to zeros
        en        : in std_logic; --! Enable signal
        shift_in  : in std_logic; --! Input signal for the shift register
        shift_out : out std_logic; --! Output signal of the shift register
        q         : out std_logic_vector(WIDTH - 1 downto 0) --! Output data of the shift register
    );
end entity Generic_Shift_Register;

architecture Behavioral of Generic_Shift_Register is
    -- Internal signals:
    --! Internal signal for the shift register
    signal reg : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
begin
    shifter_with_enable : if WITH_ENABLE generate -- Generovat podmínku pro případ, že je povoleno posouvání
        shift_register : process (clk, reset)
        begin
            if reset = '1' then
                reg <= (others => '0'); -- Resetovat posuvný registr na počáteční hodnotu
            elsif rising_edge(clk) then
                if en = '1' then
                    if shift_in = '1' then
                        reg <= reg(WIDTH - 2 downto 0) & '1'; -- Posunout data vlevo a na nejvyšší bit vložit hodnotu signálu shift_in
                    else
                        reg <= reg(WIDTH - 1 downto 1) & '0'; -- Pouze posunout data vlevo
                    end if;
                end if;
            end if;
        end process shift_register;
    end generate shifter_with_enable;

    shifter_without_enable : if not WITH_ENABLE generate -- Generovat podmínku pro případ, že není povoleno posouvání
        shift_register : process (clk, reset)
        begin
            if reset = '1' then
                reg <= (others => '0'); -- Resetovat posuvný registr na počáteční hodnotu
            elsif rising_edge(clk) then
                if shift_in = '1' then
                    reg <= reg(WIDTH - 2 downto 0) & '1'; -- Posunout data vlevo a na nejvyšší bit vložit hodnotu signálu shift_in
                else
                    reg <= reg(WIDTH - 1 downto 1) & '0'; -- Pouze posunout data vlevo
                end if;
            end if;
        end process shift_register;
    end generate shifter_without_enable;

    shift_out <= reg(WIDTH - 1); -- Výstupní signál odpovídá nejvyššímu bitu posuvného registru
    q         <= reg; -- Výstupní data posuvného registru
end architecture Behavioral;