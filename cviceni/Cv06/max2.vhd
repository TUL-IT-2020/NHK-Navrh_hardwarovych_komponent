-- pouziti funkce deklarovane v package

PACKAGE pkg_fce IS
  	CONSTANT max : INTEGER := 150 ;
	FUNCTION check_max(a: INTEGER) RETURN BIT;
END pkg_fce;

PACKAGE BODY pkg_fce IS
	FUNCTION check_max(a: INTEGER) RETURN BIT IS
   		VARIABLE t: BIT;
	BEGIN
    	    IF (a > MAX) THEN t:= '1';
	    ELSE              t:= '0';
    	    END IF;
	RETURN(t);
	END check_max;
END pkg_fce;

library work;
use work.pkg_fce.check_max;

entity max2 is
  port (vstup : in integer range 0 to 255;
        vystup : out bit);
end max2;

architecture a_max of max2 is
begin
vystup <= check_max(vstup);
end a_max;
