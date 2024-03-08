--multiplexer 4 na 1

ENTITY mux4_1 IS
	PORT
	(	d0, d1, d2, d3	: IN  BIT;
		s		: IN  INTEGER RANGE 0 TO 3;	
		o		: OUT BIT	);
END mux4_1;

ARCHITECTURE amux OF mux4_1 IS
BEGIN

WITH s SELECT
	o <=	d0 WHEN 0,
		d1 WHEN 1,
		d2 WHEN 2,
		d3 WHEN 3;
		
END amux;

