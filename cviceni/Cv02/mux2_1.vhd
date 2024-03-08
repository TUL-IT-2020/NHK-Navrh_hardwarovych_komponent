-- Dvou kanalovy multiplexor pomoci konstrukce when-else

entity mux2_1 is
   port (
      x0, x1 	: in  bit;
      a 	: in  bit;
      y 	: out bit
   );
end mux2_1;

architecture mux of mux2_1 is
begin
   y <= x1 when a = '1' else x0;
end mux;
