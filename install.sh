#!/usr/bin/env bash

# Verificare privilegii
if [[ $EUID -ne 0 ]]; then
   echo "Eroare: Te rugăm să rulezi cu sudo (sudo ./install.sh)"
   exit 1
fi

echo "Instalare NanoFetch..."

# Mutare fișier în /usr/local/bin
cp nanofetch.sh /usr/local/bin/nanofetch
chmod +x /usr/local/bin/nanofetch

echo "NanoFetch a fost instalat cu succes!"
echo "Tastază 'nanofetch' pentru a-l folosi."
