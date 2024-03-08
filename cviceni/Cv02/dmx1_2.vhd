-- Dvou kanalovy demultiplexor pomoci prirazeni s konstrukci when-else

entity dmx1_2 is
   port (
      x 	: in  bit;
      a 	: in  bit;
      y0, y1 	: out bit
   );
end dmx1_2;

architecture dmx of dmx1_2 is
begin
   y0 <= x when a = '0' else '0';
   y1 <= x when a = '1' else '0';
end dmx;
