-- enkoder

entity encoder is
  port (
	invec	: in  bit_vector(3 downto 0);
        enc_out	: out bit_vector(1 downto 0)
        );
end encoder;

architecture rtl of encoder is

begin
  enc_out <= "11" when invec(3) = '1' else
             "10" when invec(2) = '1' else
             "01" when invec(1) = '1' else
             "00" when invec(0) = '1' else
             "00";

end rtl;
