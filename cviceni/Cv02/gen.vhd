-- ukazka vyuziti prikazu Generic

entity gen is 
generic (N : integer:= 2;
	 D : time := 10 ns);
port ( 
	A, B : in bit_vector(N-1 downto 0);
	Q  : out bit_vector(N-1 downto 0));
end gen;

architecture a_gen of gen is
begin
   Q <= A and B after D;
end a_gen;