--top

library ieee;
use ieee.std_logic_1164.all;

entity rom_read is
  port
  (
    clk_in      : in std_logic;
    rst_in      : in std_logic;
    segm1_out   : out std_logic_vector(6 downto 0);
    segm2_out   : out std_logic_vector(6 downto 0);
    stav_reg_O2 : out std_logic_vector(1 downto 0);
    sw_in       : in std_logic
  );
end rom_read;

architecture struct of rom_read is
  signal s_clk            : std_logic;
  signal s_disp_timer_en  : std_logic;
  signal s_disp_timer_out : std_logic;
  signal s_segm1_num4     : std_logic_vector(3 downto 0);
  signal s_segm2_num4     : std_logic_vector(3 downto 0);
  signal s_rom_addr4      : std_logic_vector(3 downto 0);
  signal s_rom_num8       : std_logic_vector(7 downto 0);
  signal s_addr_cnt_en    : std_logic;
  signal s_addr_rst       : std_logic;
  signal s_sw_2reg        : std_logic;
  signal s_addr_cmpr      : std_logic;

begin

  --delicka vstupniho kmitoctu
  Inst_clock_div : entity work.clock_div port map
    (
    clk_in  => clk_in,
    clk_out => s_clk
    );

  --dvojity synchronizator
  Inst_input_bit_reg : entity work.input_bit_reg port
    map(
    clk  => s_clk,
    inp  => sw_in,
    outp => s_sw_2reg
    );

  --casovac
  Inst_timer : entity work.timer port
    map(
    clk_in       => s_clk,
    reset_in     => rst_in,
    timer1_en_in => s_disp_timer_en,
    timer1_out   => s_disp_timer_out
    );

  --pamet rom
  Inst_rom16x8 : entity work.rom16x8 port
    map(
    address => s_rom_addr4,
    outp    => s_rom_num8
    );

  --citac adres pameti ROM
  Inst_cnt4 : entity work.cnt4 port
    map(
    clk_in   => s_clk,
    en_in    => s_addr_cnt_en,
    srst_in  => s_addr_rst,
    cnt4_out => s_rom_addr4
    );

  --komparator
  Inst_cmpr4 : entity work.cmpr4 port
    map(
    a_in4     => s_rom_addr4,
    b_in4     => X"F",
    equal_out => s_addr_cmpr
    );

  s_segm1_num4 <= s_rom_num8(3 downto 0);
  s_segm2_num4 <= s_rom_num8(7 downto 4);

  --dekodery 7segmentoveho displeje
  Inst_dec_7segm1 : entity work.dec_7segm port
    map(
    input4  => s_segm1_num4,
    output7 => segm1_out
    );
  Inst_dec_7segm2 : entity work.dec_7segm port
    map(
    input4  => s_segm2_num4,
    output7 => segm2_out
    );

  --stavovy automat
  Inst_control_sm : entity work.control_sm port
    map(
    clk_in          => s_clk,
    tlac_in         => s_sw_2reg,
    timer_exp_in    => s_disp_timer_out,
    stav_reg_O2     => stav_reg_O2,
    addr_cmpr_in    => s_addr_cmpr,
    addr_cnt_ce_out => s_addr_cnt_en,
    addr_rst_out    => s_addr_rst,
    timer_en_out    => s_disp_timer_en
    );

end struct;