#Linux 
# Stažení QUARTUS Prime Lite
Stáhneme starší verzi, která má podporu pro naší vývojovou desku:
- [Version 19.1 for Linux](https://www.intel.com/content/www/us/en/software-kit/664524/intel-quartus-prime-lite-edition-design-software-version-19-1-for-linux.htmlhttps://www.intel.com/content/www/us/en/software-kit/664524/intel-quartus-prime-lite-edition-design-software-version-19-1-for-linux.html)

## Spuštení na linuxu
Quartus GUI spouštíme z adresáře:
`<quartus_install_dir>/quartus/bin/quartus`

A Quartus shell spouštíme z adresáře:
`<quartus_install_dir>/quartus/bin/quartus_sh`

## Vytvoření ikony
Tutoriál [[How to create a launcher for your application in Ubuntu|zde]].

Soubor: `quartus.desktop`

```
[Desktop Entry]
Encoding=UTF-8
Name=Quartus
Comment=Quartus Prime Lite Edition GUI
Version=19
Icon="~/intelFPGA_lite/19.1/quartus/adm/quartusii.png"
Exec="~/intelFPGA_lite/19.1/quartus/bin/quartus --64bit"
Terminal=false
Type=Application
Categories=Development
StartupWMClass=Quartus
StartupNotify=true
```