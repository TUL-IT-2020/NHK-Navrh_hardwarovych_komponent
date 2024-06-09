# Otázky na NHK

## Možné otázky:
11 otázek:
1. popsat metodu návrhu zdola nahoru
2. testbench a jeho výhody
3. popis stavových automatu ve vhdl
4. jak se programuje funkce v zakázkových programovatelných obvodech
5. kód vhdl - jeden byl se signalami a druhy s proměnnou, zda jsou ekvivalentní a proč
6. kód vhdl - klopny obvod D s enable
7. co je to časová doména a jak se resi přenos signálu mezi nimi
8. DSP bloky v FPGA, k čemu jsou a z čeho se skládají
9. nakreslit hradlo NOR pomoci CMOS
10. respin architektura, popsat k čemu je
11. jak se porovnává velikost bloku v FPGA

## VHDL

### Syntax

Jaký je rozdíl mezi příkazy jazyka WHDL: 
- WITH - SELECT - WHEN,
- IF - THEN - ELSE.

Co jsou to IP jádra, jak se rozdělují a kdy je výhodné je použít?
Co jsou to makrobuňky a k čemu slouží?

Jaký je rozdíl mezi proměnnou a signálem ve VHDL? Kdy je vhodné použít proměnnou a kdy signál?

Co je to package ve VHDL a k čemu slouží?

Jaký je rozdíl mezi funkcí a procedurou ve VHDL? Kdy je vhodné použít funkci a kdy proceduru?

Jaký je rozdíl mezi kombinační a sekvenční logikou? Uveďte příklady obou typů logiky.

Ve kterých částech popisu je možné v jazyce VHDL. deklarovat komponentu?

Kdy je vhodné použít mód portu BUFFER?

Jak ve VHDL popisujeme stavové automaty? Jaký je rozdíl mezi popisem stavového automatu typu Mealy a Moore?

Co je testbench (k čemu se používá, jaké má výhody, co je pro něj typické)?
### Poznej kód
Jsou uvedené dva příklady ekvivalentní a proč?
```VHDL
ARCHITECTURE ar_cnt OF cnt IS
    signal cnt1 : unsigned(3 downto 0);
BEGIN
    PROCESS (clk)
    BEGIN
        IF (clk'event and clk = '1') THEN
            cntl <= cnt1 + 1;
            IF (cntl >= 9) THEN
                cntl <= (others => '0');
            END IF;
        END IF;
        countl <= cntl;
    END PROCESS;
END ar_cnt;
```

```VHDL
ARCHITECTURE ar_cnt OF cnt IS
BEGIN
    PROCESS (clk)
        variable cntl : unsigned(3 downto 0);
    BEGIN
        IF (clk'event and clk = '1') THEN
            cntl := cntl + 1;
            IF (cntl >= 9) THEN
                cntl := (others => '0');
            END IF;
        END IF;
        countl <= cntl;
    END PROCESS;
END ar_cnt;
```
Jsou uvedené dva příklady ekvivalentní a proč?
```VHDL
SIGNAL a, b, c : bit;
PROCESS (b)
BEGIN
    a <= b;
    c <= a;
END PROCESS;
```

```VHDL
SIGNAL b, c : bit;
PROCESS (b)
    VARIABLE a : bit;
BEGIN
    a := b;
    c <= a;
END PROCESS;
```

Jsou uvedené příklady ekvivalentní a proč?
```VHDL
seg <= "0001" WHEN vstup "00" ELSE
       "1011" WHEN vstup "01" ELSE
       "0011";
```

```VHDL
CASE vstup IS
    WHEN "00" => seg <= "0001";
    WHEN "01" => seg <= "1011";
    WHEN OTHERS => seg <= "0011";
END CASE;
```

Jaký obvod popisuje uvedený proces? Nakreslete schéma nebo značku a pojmenujte
jednotlivé signály.

```VHDL
PROCESS (a)
BEGIN
    IF (a'event AND a = '1') THEN
        IF b = '1' THEN
            c <= not c;
        END IF;
    END IF;
END PROCESS;
```

Jaký obvod popisuje uvedený proces (nakreslete schéma nebo značku)?
```VHDL
PROCESS (x)
BEGIN
IF (x'event AND x = '1') THEN
    IF y = '1' THEN
        z <= w;
    END IF;
END PROCESS;
```

Co popisuje uvedený proces? Nakreslete schéma nebo značku a pojmenujte jednotlivé signály.
```VHDL
PROCESS (a, b, c)
BEGIN
    IF (a = '1') THEN
        d <= b AND c;
    END IF;
END PROCESS;
```

Jaký obvod popisuje uvedený proces (nakreslete schéma nebo značku)?
```VHDL
PROCESS (yy, zz)
BEGIN
    IF YY = '1' THEN
        ff <= '0';
    ELSIF (zz'event AND z z = '1') THEN
        ff <= not ff;
    END IF;
END PROCESS;
```

Co popisuje uvedený proces? Nakreslete schéma nebo značku a pojmenujte jednotlivé signály.
```vhdl
entity test is
port (
    a,b : in bit;
    c,d : out bit);
end test;

architecture test a of test is
begin
    c <= a when b = '0' else '0';
    d <= a when b = '1' else '0';
end test a;
```

Jaký obvod popisuje uvedený proces? Zakreslete schéma nebo značku a jednotlivé signály ("d" je 4bitový signál, "e" je jednobitový signál).
```VHDL
process (a, b) begin
    if (a = '1') then
        d <= (others => '0');
    elsif (b' event and b = '1') then
        if (clk = '1') then
            d <= d(2 downto 0) & e;
        end if;
    end if;
end process;
```

## FPGA
### Architektura
Jaký je rozdíl mezi vloženou (embedded) pamětí a distribuovanou pamětí v FPGA obvodech?

Co je to LUT, kde se používá a na jakých principech funguje?

K čemu slouži a na jakém principu pracuji PLL bloky v FPGA obvodech?
Na jakém principu je založeno násobení vstupních frekvencí v obvodech FPGA? Jaké bloky se k tomuto účelu používají? Naznačte jejich hlavní části (blokové schéma).

Jakým způsobem se srovnává velikost obvodů FPGA?

Jaký je účel DSP bloků v FPGA obvodech? Z čeho se skládají?
Jakým způsobem se měří výkon FPGA obvodů při zpracování číslicového signálu?

Z jakého důvodu se nedoporučuje používání asynchronních klopných obvodů typu RS
v obvodech FPGA?
### Programování FPGA
Na jakých technologiích (principech) je založeno ukládání funkce (programování) v programovatelných zakázkových obvodech? Uveďte výhody a nevýhody jednotlivých typů.

Uveďte základni druhy programovatelných zákaznických obvodů a stručné popište (příp. nakreslete) vnitřní architektury jednotlivých druhů.

Na jakých principech je založeno programováni programovatelných zakáznických obvodů? Uveďte výhody a nevýhody jednotlivých typů.

K čemu slouží antipojistky (antifuse) v programovatelných obvodech? Jaké mají výhody a nevýhody oproti pamětím typu SRAM a EEPROM?
### Metastability
Jak eliminujeme metastability v obvodech FPGA při přenosu signálu (po zběrnici) mezi dvěma časovými doménami?

Co jsou metastability a jak se eliminují?
Vysvětlete, jakým způsobem/principem dvojitý synchronizátor eliminuje metastability.

Co je časová doména a jak řešíme přenos signálů mezi časovými doménami?
### Napěťové standardy a I/O
Napěťové standardy I/0 buněk FPGA obvodů se dělí na dvě skupiny (single-ended a differential). Uveďte jejich výhody a nevýhody; u každé skupiny jmenujte alespoň jednoho představitele.

Kolik napájecích napětí má typický obvod FPGA a k čemu se používají?
Proč se I/O buňky FPGA obvodů sdružují do bank? Jaký je účel banky?

## Číslicová technika

Jaké jsou možnosti při realizaci HW sčítačky? Vyjmenujte možné varianty.
## Testy

uvedte typy obvodu asic obvodu
rozdil mezi promennou a signlem
package
triprocesorovy zapis
meta stability 
zakladni funkcni bloky IO
metoda RAZ 

programovatelne zakazkove obvody
deklarace konmponenty
mod prob buffer
funkce vs procedura ve VHDL
citlive promenne 
pll bloky v FPGA 
zapojeni invertoru a jeho zavislost
boundry scan
lut

kombinacni vs sekvencni 


6.5.2019
1) Pro uchovávání konfiguračních dat v FPGA obvodech se nejčastější používaná technologie založená na pamětech SRAM. Jaké má tato technologie výhody oproti ostatním používaným technologiím (anti-fuse nebo EEPROM)?
2) Na jakém principu se realizuje kombinační a sekvenční logika v obvodech CPLD (Complex Programmable Logic Device)?
3) Jakým způsobem se principiálně popisují stavové automaty v jazyce VHDL? Jaký je rozdíl mezi popisem stavového automatu typu Mealy a Moore?
4) Nakreslete základní zapojení invertoru v technologii **CMOS** a jeho závislost $U_2 = f(U_l)$. Za jakých podmínek nastává změna $U_2$ právě při $U_l$ rovnající se zhruba polovině napájecího napětí?
5) Ve třívoltové technologii **CMOS** je možné zatížit I/O buňku maximálním výstupním proudem $2 mA$. Na výstupním pinu je připojena zátěž o parazitní kapacitě $40 pF$. Jaká maximální frekvence signálu může být zhruba přenášena na tomto pinu?
7) K čemu slouží seznam citlivých signálů (sensitivity list) u příkazu „process" a co uvádíme v tomto seznamu jednak u kombinačních obvodů a jednak u sekvenčních obvodů?
8) Naznačte příčiny vzniku metastability v elektronických obvodech. V čem spočívá nebezpečnost metastabilit?
9) Vstupně-výstupní buňky FPGA obvodů sdružují do bank. Co označujeme pojmem banka a jaký je její účel?
10) Naznačte princip metody Random Access Scan při testování integrovaných obvodů. Uveďte její výhody a nevýhody ve srovnání s jinými metodami typu Scan.
11) Na obrázku je principiální schéma jedné základní aritmetické operace (vstupem je N-bitové číslo a). O jakou operaci se jedná? Popište princip činnosti.

![[schema.PNG]]

Další otázky:

2019
Co jsou to adaptivní logické moduly? Kde se používají? Jaké mají výhody?

Naznačte smysl/princip metody nazývané „synchronizace registrů” (Register retiming) při návrhu obvodů. Jaké přináší výhody?

2009

K čemu slouží metoda Boundry Scan? Naznačte její princip. výhody a nevýhody.

K čemu slouží metoda RAZ a jaký je její princip?

Co znamená návrh metodou „shora-dolů” a kdy je výhodné jej použít?

Co víte o diagnostických prostředcích typu BIST (Built-ln Self Test)? Uveďte jejich základní bloky.




