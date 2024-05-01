--stavovy automat

library ieee;
use ieee.std_logic_1164.all;

entity control_sm is
    port
    (
        clk_in          : in std_logic;
        tlac_in         : in std_logic;
        timer_exp_in    : in std_logic;
        addr_cmpr_in    : in std_logic;
        stav_reg_O2     : out std_logic_vector(1 downto 0);
        addr_cnt_ce_out : out std_logic;
        addr_rst_out    : out std_logic;
        timer_en_out    : out std_logic
    );
end control_sm;

architecture behav of control_sm is
    signal stav_reg, dalsi_stav : std_logic_vector(1 downto 0) := "00";

begin

    -- realizace pameti stavu automatu
    process (clk_in)
    begin
        if clk_in'event and clk_in = '1' then
            stav_reg <= dalsi_stav;
        end if;
    end process;

    -- prechodova funkce automatu
    process (stav_reg, tlac_in, timer_exp_in, addr_cmpr_in)
    begin
        -- implicitne zustava automat ve stavu v kterem se prave nachazi
        dalsi_stav <= stav_reg;

        -- prechodove podminky vedouci na jiny stav
        case stav_reg is
            when "00" =>
                case tlac_in is
                    when '1'    => dalsi_stav    <= "01";
                    when others => dalsi_stav <= "00";
                end case;

            when "01" =>
                case timer_exp_in is
                    when '1'    => dalsi_stav    <= "10";
                    when others => dalsi_stav <= "01";
                end case;

            when "10" =>
                case addr_cmpr_in is
                    when '1'    => dalsi_stav    <= "00";
                    when others => dalsi_stav <= "01";
                end case;

            when others =>
                dalsi_stav <= "00";
        end case;
    end process;

    -- vystupni funkce automatu
    process (stav_reg)
    begin
        case stav_reg is
            when "00" =>
                addr_cnt_ce_out <= '0';
                timer_en_out    <= '0';
                addr_rst_out    <= '1';

            when "01" =>
                addr_cnt_ce_out <= '0';
                timer_en_out    <= '1';
                addr_rst_out    <= '0';

            when "10" =>
                addr_cnt_ce_out <= '1';
                timer_en_out    <= '0';
                addr_rst_out    <= '0';

            when others =>
                addr_cnt_ce_out <= '0';
                timer_en_out    <= '0';
                addr_rst_out    <= '1';
        end case;
    end process;

    stav_reg_O2 <= stav_reg;

end behav;