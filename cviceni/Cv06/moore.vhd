-- priklad stavoveho automatu typu Moore

library ieee;
use ieee.std_logic_1164.all;

entity moore is
   port (
      clk : in std_logic;
      i0, i1, i2 : in std_logic;
      o0, o1, o2 : out std_logic
   );
end moore;

architecture behav of moore is
   type stavy is (s0, s1, s2, s3);
   signal stav_reg, dalsi_stav : stavy := s0;
begin
   -- realizace pameti stavu automatu
   process (clk)
   begin
      if clk'event and clk = '1' then
         stav_reg <= dalsi_stav;
      end if;
   end process;

   -- prechodova funkce automatu
   process (stav_reg, i0, i1, i2)
   begin
      -- implicitne zustava automat ve stavu v kterem se prave nachazi
      dalsi_stav <= stav_reg;

      -- prechodove podminky vedouci na jiny stav
      case stav_reg is
         when s0 =>
            if i0 = '1' or i2 = '1' then
               dalsi_stav <= s1;
            end if;
         when s1 =>
            if i0 = '1' then
               dalsi_stav <= s2;
            elsif i1 = '1' then
               dalsi_stav <= s0;
            elsif i2 = '1' then
               dalsi_stav <= s3;
            end if;
         when s2 =>
            if i1 = '1' then
               dalsi_stav <= s0;
            end if;
         when s3 =>
             dalsi_stav <= s3;
         when others =>
            dalsi_stav <= stav_reg;
      end case;
   end process;

   -- vystupni funkce automatu
   process (stav_reg)
   begin
      case stav_reg is
         when s0 =>
            o0 <= '1';
            o1 <= '0';
            o2 <= '0';
         when s1 =>
            o0 <= '1';
            o1 <= '0';
            o2 <= '0';
         when s2 =>
            o0 <= '0';
            o1 <= '1';
            o2 <= '0';
         when s3 =>
            o0 <= '0';
            o1 <= '0';
            o2 <= '1';
         when others => null;
      end case;
   end process;
end behav;
