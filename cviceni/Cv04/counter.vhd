-- citac vpred a vzad s synchronnim nulovanim a enablem

ENTITY counter IS
	PORT (
		clk	: IN	BIT;
		clear	: IN	BIT;
		enable	: IN	BIT;
		up_down	: IN	BIT;
		q	: OUT INTEGER RANGE 0 TO 255
		);
END counter;

ARCHITECTURE a_counter OF counter IS
BEGIN

    PROCESS (clk)
 	VARIABLE cnt	   : INTEGER RANGE 0 TO 255;
	VARIABLE direction : INTEGER;
    BEGIN
	IF (up_down = '1') THEN
		direction := 1;
	ELSE
		direction := -1;
	END IF;
		
	IF (clk'EVENT AND clk = '1') THEN
		IF clear = '0' THEN
			cnt := 0;
		ELSE
			IF enable = '1' THEN
				cnt := cnt + direction;
			END IF;
		END IF;
	END IF;

    q <= cnt;

    END PROCESS;

END a_counter;

