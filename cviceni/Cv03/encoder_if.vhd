-- enkoder pomoc� prikazu if

entity encoder_if is
  port
  (
    invec   : in bit_vector(3 downto 0);
    enc_out : out bit_vector(1 downto 0)
  );
end encoder_if;

architecture a_enc of encoder_if is
begin

  process (invec)
  begin

    if invec(3) = '1' then
      enc_out <= "11";
    elsif invec(2) = '1' then
      enc_out <= "10";
    elsif invec(1) = '1' then
      enc_out <= "01";
    else
      enc_out <= "00";
    end if;

  end process;
end a_enc;