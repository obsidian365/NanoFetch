#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo "Eroare: Te rugăm să rulezi cu sudo."
   exit 1
fi

echo "Dezinstalare NanoFetch..."

if [ -f /usr/local/bin/nanofetch ]; then
    rm /usr/local/bin/nanofetch
    echo "NanoFetch a fost eliminat din sistem."
else
    echo "NanoFetch nu a fost găsit în /usr/local/bin."
fi
