-- popis multiplexeru příkazem case

entity MUX_CASE is
  port (
	B 	: in bit_vector (3 downto 0);
      SEL 	: in bit_vector (1 downto 0);
      Y 	: out bit
		);
end MUX_CASE;

architecture MUX_BODY of MUX_CASE is
begin
  process (B, SEL)
  begin
    case SEL is
      when "00" => Y <= B(0);
      when "01" => Y <= B(1);
      when "10" => Y <= B(2);
      when "11" => Y <= B(3);
    end case;
  end process;
end MUX_BODY;
