-- aritmeticko-logicka jednotka

package ALU_TYPY is
  type OPTYPE is (add, sub, mul, div);
end ALU_TYPY;

use work.ALU_TYPY.all;

entity ALU is
  port
  (
    A, B : in integer range 0 to 63;
    OPER : in OPTYPE;
    Y    : out integer);
end alu;

architecture ALU_BODY of ALU is
begin

  ALU_P : process (A, B, OPER)
  begin
    case OPER is
      when add    => Y <= A + B;
      when sub    => Y <= A - B;
      when mul    => Y <= A * B;
      when div    => Y <= A / B;
      when others => null;
    end case;
  end process;

end ALU_BODY;