# NanoFetch 2.0.0

**NanoFetch** este un script Bash minimalist și rapid, conceput pentru a afișa informații esențiale despre sistem direct în terminal, însoțite de un logo ASCII elegant și bare de progres pentru resurse.

## Caracteristici
- **Rapiditate:** Colectează datele direct din `/proc` și `/etc/os-release`.
- **Vizual:** Include bare de progres colorate pentru RAM, Swap și Disc.
- **Universal:** Detectează pachetele pentru majoritatea distribuțiilor (Arch, Debian, Fedora, NixOS, etc.).
- **Informativ:** Afișează IP-ul local, Kernel-ul, Uptime-ul și încărcarea procesorului (Load).

## Demo
```text
    _  _   __   _  _   __  
   | \| | /__\ | \| | /  \ 
   | .  |/    \| .  || () |
   |_|\_|\_/\_/|_|\_| \__/ 
  nanofetch 2.0.0  •  22.03.2026 12:00
  ------------------------------------------
  User           user@linux-host
  OS             Ubuntu 24.04 LTS
  Kernel         6.8.0-generic [x86_64]
  RAM:           ████░░░░░░░░░░░░ 25%

## Instalare
Clonează repository-ul:
git clone [https://github.com/utilizator/nanofetch.git](https://github.com/utilizator/nanofetch.git)
cd nanofetch
sudo ./install.sh

## Utilizare
Pur si simplu tastati in terminal
nanofetch

## Dezinstalare
sudo ./uninstall.sh

Autor: Bugulet Ciprian-Dumitru
