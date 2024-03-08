-- kombinacni logicky obvod

entity klo_if is
  port
  (
    A, B, C, X : in integer range 0 to 7;
    Z          : out integer range 0 to 7
  );
end klo_if;

architecture a_if of klo_if is
begin
  process (A, B, C, X)
  begin

    if (X > 5) then
      Z <= A;
    elsif (X < 5) then
      Z <= B;
    else
      Z <= C;
    end if;

  end process;
end a_if;