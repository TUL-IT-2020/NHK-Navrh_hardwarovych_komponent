-- ukazka pouziti obousmerne sbernice

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bidir IS
    PORT(
        bidir   : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        oe, clk : IN STD_LOGIC;
        inp     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        outp    : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		  );
END bidir;

ARCHITECTURE a_bidir OF bidir IS
SIGNAL  a  : STD_LOGIC_VECTOR (7 DOWNTO 0); -- pomocny vstup
SIGNAL  b  : STD_LOGIC_VECTOR (7 DOWNTO 0); -- pomocny vystup

BEGIN
    PROCESS(clk)
    BEGIN
    IF clk'EVENT AND clk = '1' THEN 
        a <= inp;                    
        outp <= b;                  
        END IF;
    END PROCESS;  
	 
    PROCESS (oe, bidir)      -- popis obousmesneho budice
        BEGIN                   
        IF( oe = '0') THEN
            bidir <= (OTHERS => 'Z');
            b <= bidir;
        ELSE
            bidir <= a; 
            b <= bidir;
        END IF;
    END PROCESS;
END a_bidir;