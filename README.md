<img width="641" height="224" alt="nanofetch_logo2" src="https://github.com/user-attachments/assets/f77473b6-708e-473f-b183-81cb0d9fee5c" />

NanoFetch: Un Fetcher Bash Minimalist și Rapid

NanoFetch este un script Bash ultra-minimalist pentru afișarea rapidă a informațiilor esențiale despre sistemul de operare Linux. Conceput pentru viteză, NanoFetch elimină logo-urile complexe și funcțiile inutile, concentrându-se exclusiv pe datele vitale, aliniate curat pe stânga.

Caracteristici Cheie

Viteză: Execuție aproape instantanee, ideal pentru integrarea în .bashrc sau .zshrc.

Minimalism: Fără logo-uri ASCII sau dependențe externe majore.

Informații esențiale: Afișează imediat date critice de sistem.

Portabilitate: Funcționează pe orice sistem care are Bash și utilitarele standard Unix (grep, awk, df, uname).

Instalare
Instalarea NanoFetch este rapidă și manuală.

1. Descărcarea Scriptului
wget -O nanofetch https://raw.githubusercontent.com/yourusername/nanofetch/main/nanofetch
2. Acordarea Permisiunilor
Faceți scriptul executabil:

Bash

chmod +x nanofetch
3. Instalarea Globală (Opțional)
Pentru a putea rula NanoFetch de oriunde, mutați-l într-un director din variabila voastră de mediu $PATH:

Bash

sudo mv nanofetch /usr/local/bin/
