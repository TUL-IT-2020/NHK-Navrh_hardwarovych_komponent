library work;
use work.pkg_fce.check_max;

entity max1 is
  port (vstup : in integer range 0 to 255;
        vystup : out bit);
end max1;

architecture a_max of max1 is
begin
vystup <= check_max(vstup);
end a_max;
