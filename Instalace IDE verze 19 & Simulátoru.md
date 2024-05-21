# Instalace IDE verze 19 & Simulátoru
Stáhněte si:
- `max10-19.1.0.670.qdz`
- `QuartusLiteSetup-19.1.0.670-windows.exe`
- `ModelSimSetup-19.1.0.670-windows.exe`

Nainstalujte:
- `QuartusLiteSetup-19.1.0.670-windows.exe`
- `ModelSimSetup-19.1.0.670-windows.exe`

Pokud nebudete potřebovat nikdy nic simulovat, tak se bez ModelSimu obejdete.

## Podepsané ovladače pro USB Blaster
- [Intel aneb proč vám to kluci kurva nefunguje?](https://www.intel.com/content/www/us/en/support/programmable/articles/000085878.html)
	- [podepsaný driver](https://www.intel.com/content/dam/support/us/en/programmable/kdb/support/knowledge-center/tools/2021/usb-blaster-ii-update.zip)

Cesta k ovladači: `C:\intelFPGA_lite\19.1\quartus\drivers\usb-blaster-ii`

Pro vyřešení tohoto problému postupujte podle následujících kroků:
1. Stáhněte si aktualizovanou verzi ovladače z následujícího [odkazu](https://www.intel.com/content/dam/support/us/en/programmable/kdb/support/knowledge-center/tools/2021/usb-blaster-ii-update.zip)
2. Rozbalte stažený soubor a nahraďte soubory 'usb-blaster-ii.inf' a 'usb-blaster-ii.cat' ve složce:
    `<Quartus Installation Path\>\qprogrammer\quartus\drivers\usb-blaster-ii`
3. Spusťte Windows `Správce zařízení`
4. Najděte uzel`Altera USB-Blaster II (rozhraní JTAG)` pod `JTAG kabely` v `Správci zařízení` systému Windows*, klikněte pravým tlačítkem a vyberte 'Aktualizovat ovladač'
5. Vyberte `Prohledat můj počítač po ovladači` a klikněte na `Prohledat ovladače na tomto místě` a ukážete na nový soubor `usb-blaster-ii.inf`

> [!warning]
> Tohle stejně nefunguje protože ten ovladač je podepsaný jen do 18.6. 2021!