-- generator parity

ENTITY par IS
	PORT(
	a : IN bit;
	b : IN bit;
	c : IN bit;
	d : IN bit;
	o1 : OUT bit);
END ENTITY par;

ARCHITECTURE a_par OF par IS
SIGNAL temp1, temp2 : bit;

BEGIN
	temp1 <= a XOR b;
	temp2 <= c XOR d;
	o1 <= temp1 XOR temp2;

END ARCHITECTURE a_par;