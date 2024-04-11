-- 8bitova LIFO s hloubkou 128

library ieee;
use ieee.std_logic_1164.all;

entity LIFO is
    generic(
        WIDTH : natural := 8;
        DEPTH : natural := 128
    );
    port(
        I_DATA  : in  std_logic_vector(WIDTH - 1 downto 0); --vstupni data
        O_DATA  : out std_logic_vector(WIDTH - 1 downto 0); --vystupni data
        I_RD_WR : in  std_logic; --vstupni RD/~WR signal (1 pro cteni, 0 pro zapis)
        O_FULL  : out std_logic; --vystupni Full signal (1 pro plnou pamet)
        O_EMPTY : out std_logic; --vystupni Empty signal (1 pro prazdnou pamet).
        clk     : in  std_logic;
        rst     : in  std_logic
    );
end entity LIFO;

architecture RTL of LIFO is
    -- pomocna funkce pro konverzi Boolean na Std_logic
    function to_std_logic(B : boolean) return std_logic is
    begin
        if B = false then
            return '0';
        else
            return '1';
        end if;
    end function to_std_logic;

    type memory_type is array (0 to DEPTH - 1) of std_logic_vector(WIDTH - 1 downto 0);
    signal memory : memory_type;
begin
    main : process(clk, rst) is
        variable stack_pointer : integer range 0 to DEPTH := 0;
        variable EMPTY, FULL   : boolean := false;
    begin
        --asynchronni reset
        if rst = '1' then
            memory   <= (others => (others => '0'));
            EMPTY := true;
            FULL  := false;

            stack_pointer := 0;
        elsif rising_edge(clk) then
            if I_RD_WR = '1' then
                -- pro cteni
                if not EMPTY then
                    O_DATA        <= memory(stack_pointer);
                    stack_pointer := stack_pointer - 1;
                end if;
            else
                -- pro zapis
				if not FULL then
                    stack_pointer := stack_pointer + 1;
                    memory(stack_pointer - 1) <= I_DATA;
                end if;
            end if;

            -- kontrola prazdne pameti
            if stack_pointer = 0 then
                EMPTY := true;
            else
                EMPTY := false;
            end if;

            -- kontrola plne pameti
            if stack_pointer = DEPTH then
                FULL := true;
            else
                FULL := false;
            end if;
        end if;
        O_FULL  <= to_std_logic(FULL);
        O_EMPTY <= to_std_logic(EMPTY);
    end process main;

end architecture RTL;