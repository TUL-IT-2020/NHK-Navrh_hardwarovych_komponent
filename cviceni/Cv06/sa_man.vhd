-- priklad manualniho prirazeni vnitrnich stavu
-- dvouprocesorovy popis

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sa_man IS
   PORT (updown    : IN STD_LOGIC;
         clock     : IN STD_LOGIC;
         lsb       : OUT STD_LOGIC;
         msb       : OUT STD_LOGIC);
END sa_man;

ARCHITECTURE a_sa_man OF sa_man IS
   TYPE count_state is (zero, one, two, three);
   ATTRIBUTE syn_encoding                : STRING;
   ATTRIBUTE syn_encoding OF count_state : TYPE IS "11 01 10 00";
   SIGNAL present_state, next_state       : count_state;
BEGIN
   PROCESS (present_state, updown)
   BEGIN
      CASE present_state IS
         WHEN zero =>
            IF (updown = '0') THEN
               next_state <= one;
               lsb <= '0';
               msb <= '0';
            ELSE
               next_state <= three;
               lsb <= '1';
               msb <= '1';
            END IF;
         WHEN one =>
            IF (updown = '0') THEN
               next_state <= two;
               lsb <= '1';
               msb <= '0';
            ELSE
               next_state <= zero;
               lsb <= '0';
               msb <= '0';
            END IF;
         WHEN two =>
            IF (updown = '0') THEN
               next_state <= three;
               lsb <= '0';
               msb <= '1';
            ELSE
               next_state <= one;
               lsb <= '1';
               msb <= '0';
            END IF;
         WHEN three =>
            IF (updown = '0') THEN
               next_state <= zero;
               lsb <= '1';
               msb <= '1';
            ELSE
               next_state <= two;
               lsb <= '0';
               msb <= '1';
            END IF;
      END CASE;
   END PROCESS;
   
   PROCESS
   BEGIN
      WAIT UNTIL clock'EVENT and clock = '1';
      present_state <= next_state;
   END PROCESS;
   
END a_sa_man;

