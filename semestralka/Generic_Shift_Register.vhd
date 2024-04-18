library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Generic_Shift_Register is
    generic (
        WIDTH : integer := 8;  -- Šířka posuvného registru
        INIT_VALUE : std_logic_vector(WIDTH - 1 downto 0) := (others => '0')  -- Počáteční hodnota posuvného registru
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        shift_in : in std_logic;
        shift_out : out std_logic;
        q : out std_logic_vector(WIDTH - 1 downto 0)
    );
end entity Generic_Shift_Register;

architecture Behavioral of Generic_Shift_Register is
    signal reg : std_logic_vector(WIDTH - 1 downto 0) := INIT_VALUE;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            reg <= INIT_VALUE;  -- Resetovat posuvný registr na počáteční hodnotu
        elsif rising_edge(clk) then
            if shift_in = '1' then
                reg <= reg(WIDTH - 2 downto 0) & '1';  -- Posunout data vlevo a na nejvyšší bit vložit hodnotu signálu shift_in
            else
                reg <= reg(WIDTH - 1 downto 1) & '0';  -- Pouze posunout data vlevo
            end if;
        end if;
    end process;

    shift_out <= reg(WIDTH - 1);  -- Výstupní signál odpovídá nejvyššímu bitu posuvného registru
    q <= reg;  -- Výstupní data posuvného registru
end architecture Behavioral;
