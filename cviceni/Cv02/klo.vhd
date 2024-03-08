-- kombinacni logicky obvod

entity klo is
port (
	A,B,C,X : in  integer range 0 to 7;
	  Z 	: out integer range 0 to 7
);
end klo;

architecture a_podm of klo is
begin
   Z <= A when X > 5 else
	B when X < 5 else
    	C ;
end a_podm ;
