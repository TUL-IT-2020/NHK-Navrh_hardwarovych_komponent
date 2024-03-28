-- popis hradla XOR z komponent

entity x_or is
  port
  (
    in1, in2 : in bit;
    out1     : out bit);
end x_or;

entity hr_and is
  port
  (
    a, b : in bit;
    c    : out bit);
end hr_and;

architecture behavior of hr_and is
begin
  process (a, b)
  begin
    c <= a and b;
  end process;
end behavior;

entity hr_or is
  port
  (
    d, e : in bit;
    f    : out bit);
end hr_or;

architecture behavior of hr_or is
begin
  process (d, e)
  begin
    f <= d or e;
  end process;
end behavior;

entity invert is
  port
  (
    g : in bit;
    h : out bit);
end invert;
architecture behavior of invert is
begin
  process (g)
  begin
    h <= not g;
  end process;
end behavior;

architecture structural of x_or is
  signal t1, t2, t3, t4 : bit;

  component hr_and
    port
    (
      a, b : in bit;
      c    : out bit);
  end component;

  component hr_or
    port
    (
      d, e : in bit;
      f    : out bit);
  end component;

  component invert
    port
    (
      g : in bit;
      h : out bit);
  end component;

begin
  u0 : hr_and port map
    (a => t1, b => in2, c => t3);
  u1 : hr_and port
  map (a => in1, b => t2, c => t4);
  u2 : invert port
  map (g => in1, h => t1);
  u3 : invert port
  map (g => in2, h => t2);
  u4 : hr_or port
  map (d => t3, e => t4, f => out1);
end structural;