-- Dvouadresovy spinac (4 vstupy a 4 vystupy) 

entity switch is
   port (e: in bit_vector (3 downto 0);   
         s: in bit_vector (1 downto 0);   
         d: out bit_vector (3 downto 0)); 
end switch;

architecture rtl of switch is
   signal t : bit_vector(3 downto 0);     

   begin
   t(3) <= s(1) and s(0);                   
   t(2) <= s(1) and not s(0);
   t(1) <= not s(1) and s(0);
   t(0) <= not s(1) and not s(0);

   d <= e and t;

end rtl;