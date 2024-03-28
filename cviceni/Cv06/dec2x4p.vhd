--dekoder reseny pomoci procedury

library IEEE;
use IEEE.std_logic_1164.all;

entity dec2x4p is port (
	decIn: in std_logic_vector(1 downto 0);
	decOut: out std_logic_vector(3 downto 0)
	);
end dec2x4p;

architecture simple of dec2x4p is

  procedure DEC2x4 (signal inputs : in std_logic_vector(1 downto 0);
                    signal decode : out std_logic_vector(3 downto 0)
                   ) is
  begin
    case inputs is
      when "11" =>
        decode <= "1000";
      when "10" =>
        decode <= "0100";
      when "01" =>
        decode <= "0010";
      when "00" =>
        decode <= "0001";
      when others =>
        decode <= "0001";
    end case;
  end DEC2x4;

begin

process (decIn)
begin
   DEC2x4(decIn,decOut);
end process;

end simple;

