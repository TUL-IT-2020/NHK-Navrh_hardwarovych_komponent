# NHK Semestrální práce
## Zadání:
> [!Info] 
> Na šestimístném sedmisegmentovém displeji se pomalu posouvá nápis „AHOJ“. Ovládá se jedním tlačítkem. Jeho opakovaným stiskem se začne nápis posouvat jedním směrem, dalším stiskem se posun zastaví, při dalším stisku se začne nápis posouvat na druhou stranu a dalším stiskem tlačítka se opět zastaví.

## TODO:
- [x] Stavový automat
	- [x] Ošetření vstupů
		- [x] 2b posuvný registr
	- Výstup ovládá směr posunu
		- up/down/not_en
- [ ] Uložení textu
	- [x] ASCII -> 7-seg
	- [x] Paměť s konfigurací znaků
- [ ] Zobrazeni na výstup
	- [ ] Připojení 6x7-seg displejů
        - Cyklus postupně přistupuje jednotlivé znaky a ukládá je do 7-seg 
	- [x] Pomalý časovač pro kroky posunu textu
	- [ ] Čítač indexu posunu
		- up/down
		- 0-5

## Postup
### Stavový automat
Seznam stavů a nastavení výstupů:
- `RESET`, 
	- en = '0' 
- `LEFT`,
	- down = '1'
- `STOP_LEFT`,
	- en = '0' 
- `RIGHT`,
	- up = '1'
- `STOP_RIGHT`.
	- en = '0' 

```mermaid
graph TD; 
	RESET((RESET<br>en='0'))
	LEFT((LEFT<br>down='1'))
	STOP_LEFT((STOP_LEFT<br>en='0'))
	RIGHT((RIGHT<br>up='1'))
	STOP_RIGHT((STOP_RIGHT<br>en='0'))
	
	RESET --> LEFT; 
	LEFT --> STOP_LEFT; 
	STOP_LEFT --> RIGHT; 
	RIGHT --> STOP_RIGHT; 
	STOP_RIGHT --> LEFT;
```
Mezi stavy se přechází při zmáčknutí tlačítka. 
### ASCII
V termínech standardu je typ `character` výčtový typ, který mapuje na ISO-8859-1 (tedy ASCII pro kódy 0-127).

Existují standardní předdefinované atributové funkce na výčtové typy, které mohou převádět mezi výčtovou hodnotou a její pozicí ve výčtu (`'pos()` a `'val()`), poté je převod znaku na jeho 8-bitové kódování dost jednoduchý:
```vhdl
subtype byte is std_ulogic_vector(7 downto 0);

function char_to_byte(c : character) return byte is
begin
	return byte(to_unsigned(character'pos(c), 8));
end function;

function byte_to_character(b: byte) return character is
begin
	return character'val(to_integer(unsigned(b)));
end function;
```

- [source](https://electronics.stackexchange.com/questions/626149/does-vhdl-2008-have-built-in-function-to-convert-std-logic-vector-to-character-t)

### Zobrazování
Přepočet indexu ve stringu na posunutý index na displeji, modulo počet displejů.

```vhdl
-- io
segments : out std_logic_vector((NUMBER_OF_DIGITS * NUMBER_OF_SEGMENTS) - 1 downto 0);

-- signals
signal index : integer range 0 to 5 := 0;
signal posun : integer := 1;
signal text : string(0 to 5) := "AHOJ  ";

-- zobrazovaná číslice
process(clk)
	variable actual_index : integer range 0 to 5 := 0;
	variable segment_start : integer := 0;
	variable segment_end : integer := 0;
begin
	if rising_edge(clk) then
		actual_index := (index + posun) mod 6;
		segment_start := actual_index * 7;
		segment_end := segment_start + 6;
		segments(segment_end downto segment_start) <= char_to_seven_segment(text(actual_index));
	end if;
end process;
```

## Návrh zapojení top level

```mermaid
flowchart TD
    subgraph Input
        Button
        sync[dvojity synchronizator]
        edge[edge detection]

        Button --> sync
        sync --> edge 
    end
    
    edge --> state_machine
    state_machine -- up/down --> counter_shift
    state_machine -- enable --> counter_shift

    subgraph logic
        state_machine[state machine]
        counter_shift[index shift counter]
        counter_index
        memory

        counter_index --char_index--> memory
    end
    
    subgraph output
        7-seg[7-seg displej]
        sum((+))
        mod(["mod(x, NUMBER_OF_DIGITS)"])
        
        mod -- index --> 7-seg
    end
    
    counter_index --> sum
    counter_shift --> sum
    sum --> mod

    memory -- to_7-seg(byte) --> 7-seg

    text{{"AHOJ  "}} -.-> memory
```