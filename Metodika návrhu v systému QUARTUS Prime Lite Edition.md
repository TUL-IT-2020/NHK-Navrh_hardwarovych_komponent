# Metodika návrhu v systému QUARTUS Prime Lite Edition

## Vytvoření nového projektu
1. založení nového projektu (menu File / New Project Wizard…)
	- nastavíme pracovní adresář (např. D:\projekt)
	- zvolíme jednoslovný název (bez diakritiky, pouze písmena, číslice a příp. podtržítko)
	stejný pro projekt i top-level entitu
	- zvolíme typ projektu „Empty project“
	- máme-li zdrojový soubor (*.vhd nebo *.bdf) vybereme ho (File name, a následně Add)
	- specifikace Device family (Family: MAX 10 (DA), Device: **10M50DAF484C7G**)
	- EDA Tools Settings (nic neměníme) - Finish;
2. vytvoření zdrojového souboru (pokud ho již nemáme):
	- založení nového souboru (menu File / New / Design Files – VHDL File nebo File / New / Design Files - Block Diagram/Schematic File);
	- vytvoření popisu VHDL nebo zadání schématu Insert – Symbol… v položce Libraries: primitives / logic, příp. pin;
	(speciální uživatelské bloky jsou v položce Libraries: others /
	opencore_plus);
	- uložení souboru (menu File / Save) – „jméno.vhd“ nebo „jmeno.bdf“
	(jméno volíme shodné se zadaným jménem TopLevel entity projektu);
3. spuštění překladu (menu Processing / Start Compilation;

## Zadávání stavových automatů
1. založení nového souboru (menu File / New / Design Files - State Machine File)
2. spuštění průvodce stavovým automatem (pravé tlačítko myši, State Machine Wizard) a založení nového návrhu (Create a new state machine design):
	- výběr resetovacího módu a typů výstupů (asynchronní; výstupy bez registrů);
	- vložení všech stavů a vstupních portů;
	- vyplnění přechodové funkce (symboly použitelné v podmínce přechodové funkce:
	== (rovná se), != (nerovná se), < (menší), > (větší), <= (menší nebo rovno), >=, & (AND), │(OR), ^ (XOR), ~& (NAND), ~│ (NOR), ~^ (XNOR), ~ (NOT));
	- vložení výstupních portů a vyplnění výstupní funkce;
3. vygenerování souboru v jazyku HDL (pravé tlačítko myši, Generate HDL File…)
	- doporučeno zvolit jazyk VHDL;
4. spuštění překladu (menu Processing / Start Compilation).

## Nahrání do hradlového pole
1. specifikace FPGA – již zadáno v projektu, příp. zkontrolovat - menu Assignments / Device (Family: MAX10 (DA), Device: **10M50DAF484C7G**);
2. přiřazení pinů (menu Assignments / Pin Planner) – aby se automaticky načetly IO signály, je nutné mít projekt již zkompilovaný, zápis do polí „Location“ (PIN_číslo, stačí vkládat jen číslo) a „I/O Standard“ (zvolíme 3.3-V LVTTL, u tlačítek `KEY0` a `KEY1` volíme 3.3V Schmitt Trigger);
3. po změně typu FPGA nebo čísel pinů je třeba projekt znovu zkompilovat (menu Processing / Start Compilation);
4. spuštění nahrávání (menu Tools / Programmer). Pokud není  řednastaven programovací kabel: tlačítko Hardware Setup …, Currently selected hardware: USB-Blaster `[USB-0]`. Dále vybrat soubor k programování (`\output_files\ *.sof`), zatrhnout Program/Configure, nakonec tlačítko Start.

## Simulace
1. založení nového souboru pro simulaci (menu File -> New -> Verification/Debugging Files -> University Program VWF);
2. vložení signálů
	- menu Edit / Insert – Insert Node or Bus…
	- tlačítko Node Finder… (Named: * , Filter: Pins: All ) - tlačítko List (ze seznamu vlevo vybereme signály, které chceme zobrazit v simulaci, a přeneseme do seznamu vpravo a potvrdíme i v nadřazeném dialogu);
	- nastavení koncového času simulace (menu Edit / Set End Time…), např. jednotky µs;
	- nastavení velikosti rastru (menu Edit / Grid Size…), např. desítky ns;
	- zoomování okénka dle potřeby (např. menu View / Fit to window);
	- zadání požadovaných průběhů vstupních signálů pomocí myši, příp. periodických (hodin) pomocí dialogu;
	- uložení souboru (menu File / Save As…) – „jméno“.vwf doporučeno zvolit jméno stejné se jménem projektu;
3. spuštění simulace (menu Simulation / Run Functional Simulation);
4. spuštění simulace (menu Processing / Start Simulation);
5. výstupní průběhy se vytvoří v samostatném souboru *.sim.vwf.