#!/bin/bash
# ===============================================
# NanoFetch - Un fetcher Bash extrem de simplu
# 2.0.0 - versiune (actualizată cu logo ASCII)
# Bugulet Ciprian-Dumitru - autor
# https://ciprianbugulet.blogspot.com/ - web
# bugulet.ciprian@gmail.com - mail
# ===============================================

# ── Culori ──
CYAN='\e[36m'
YELLOW='\e[33m'
GREEN='\e[32m'
MAGENTA='\e[35m'
BLUE='\e[34m'
RED='\e[31m'
BOLD='\e[1m'
DIM='\e[2m'
NC='\e[0m'

# ── Bara progres simpla ──
progress_bar() {
    local used=$1 total=$2 width=20 pct=0 filled empty col
    [ "$total" -gt 0 ] && pct=$(( used * 100 / total ))
    filled=$(( pct * width / 100 ))
    empty=$(( width - filled ))
    col=$GREEN
    [ $pct -ge 60 ] && col='\e[33m'
    [ $pct -ge 85 ] && col='\e[31m'
    printf "${col}"
    [ $filled -gt 0 ] && printf '█%.0s' $(seq 1 $filled)
    printf "${DIM}\e[37m"
    [ $empty  -gt 0 ] && printf '░%.0s' $(seq 1 $empty)
    printf "${NC} ${YELLOW}${pct}%%${NC}"
}

# ── Print rand info ──
print_info() {
    printf "  ${CYAN}${BOLD}%-14s${NC} ${YELLOW}%s${NC}\n" "$1" "$2"
}

print_bar() {
    printf "  ${CYAN}${BOLD}%-14s${NC} " "$1"
    progress_bar $2 $3
    printf "\n"
}

# ── Colectare date ──
get_os()     { grep -oP '(?<=PRETTY_NAME=").*(?=")' /etc/os-release 2>/dev/null || uname -s; }
get_kernel() { uname -r; }
get_arch()   { uname -m; }
get_host()   { cat /etc/hostname 2>/dev/null | tr -d '\n' || hostnamectl hostname 2>/dev/null || uname -n; }
get_user()   { echo "${USER:-$(whoami)}@$(get_host)"; }
get_shell()  { basename "${SHELL:-bash}"; }

get_uptime() {
    local s; s=$(awk '{print int($1)}' /proc/uptime)
    local d=$(( s/86400 )) h=$(( (s%86400)/3600 )) m=$(( (s%3600)/60 ))
    local out=""
    [ $d -gt 0 ] && out="${d}z "
    [ $h -gt 0 ] && out="${out}${h}h "
    out="${out}${m}m"
    echo "$out"
}

get_cpu() {
    grep -m1 'model name' /proc/cpuinfo 2>/dev/null \
        | cut -d: -f2 | sed 's/^ *//;s/(R)//g;s/(TM)//g;s/  */ /g' \
        || echo "N/A"
}

get_cores() {
    local c; c=$(nproc 2>/dev/null || grep -c processor /proc/cpuinfo)
    local mhz; mhz=$(grep -m1 "cpu MHz" /proc/cpuinfo | awk '{printf "%.0f",$4}')
    echo "${c} nuclee @ ${mhz} MHz"
}

get_load()   { awk '{print $1" "$2" "$3}' /proc/loadavg; }

get_mem_vals() {
    MT=$(awk '/MemTotal/{print int($2/1024)}'     /proc/meminfo)
    MA=$(awk '/MemAvailable/{print int($2/1024)}' /proc/meminfo)
    MU=$(( MT - MA ))
}

get_swap_vals() {
    ST=$(awk '/SwapTotal/{print int($2/1024)}' /proc/meminfo)
    SF=$(awk '/SwapFree/{print int($2/1024)}'  /proc/meminfo)
    SU=$(( ST - SF ))
}

get_disk() {
    df -h / 2>/dev/null | awk 'NR==2{print $3 " / " $2 " (" $5 " folosit)"}'
}

get_disk_vals() {
    DU=$(df -BG / 2>/dev/null | awk 'NR==2{gsub(/G/,"",$3);print $3}')
    DT=$(df -BG / 2>/dev/null | awk 'NR==2{gsub(/G/,"",$2);print $2}')
}

get_ip() {
    local ip; ip=$(ip -4 addr 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '^127\.' | head -1)
    [ -z "$ip" ] && ip=$(cat /proc/net/fib_trie 2>/dev/null | awk '/32 HOST/{print f} {f=$2}' | grep -v '^127\.' | head -1)
    echo "${ip:-N/A}"
}

get_pkgs() {
    local out=""
    # Arch / Manjaro / EndeavourOS
    command -v pacman     &>/dev/null && out="${out}$(pacman -Qq 2>/dev/null | wc -l) (pacman), "
    # Debian / Ubuntu / Mint / Pop!_OS
    command -v dpkg       &>/dev/null && out="${out}$(dpkg -l 2>/dev/null | grep -c '^ii') (dpkg), "
    # Fedora / RHEL / CentOS / Rocky / AlmaLinux
    command -v rpm        &>/dev/null && out="${out}$(rpm -qa 2>/dev/null | wc -l) (rpm), "
    # openSUSE / SLES
    command -v zypper     &>/dev/null && out="${out}$(zypper se --installed-only 2>/dev/null | grep -c '^i') (zypper), "
    # Alpine Linux
    command -v apk        &>/dev/null && out="${out}$(apk info 2>/dev/null | wc -l) (apk), "
    # Gentoo
    command -v qlist      &>/dev/null && out="${out}$(qlist -I 2>/dev/null | wc -l) (portage), "
    # Void Linux
    command -v xbps-query &>/dev/null && out="${out}$(xbps-query -l 2>/dev/null | wc -l) (xbps), "
    # NixOS
    command -v nix-env    &>/dev/null && out="${out}$(nix-env -q 2>/dev/null | wc -l) (nix), "
    # Snap
    command -v snap       &>/dev/null && out="${out}$(snap list 2>/dev/null | tail -n +2 | wc -l) (snap), "
    # Flatpak
    command -v flatpak    &>/dev/null && out="${out}$(flatpak list 2>/dev/null | wc -l) (flatpak), "
    # Scoate ultima virgula+spatiu
    out="${out%, }"
    echo "${out:-N/A}"
}

# ── Logo ASCII NANO ──
print_logo() {
    printf "${CYAN}${BOLD}"
    printf "   _  _   __   _  _   __  \\n"
    printf "  | \\| | /__\\ | \\| | /  \\ \\n"
    printf "  | .  |/    \\| .  || () |\\n"
    printf "  |_|\\_|\\_/\\_/|_|\\_| \\__/ \\n"
    printf " ${NC}${DIM}\e[36m nanofetch 2.0.0  •  $(date '+%d.%m.%Y %H:%M')${NC}\n"
}

# ── Blocuri de culoare ──
print_colors() {
    printf "  "
    for c in 1 2 3 4 5 6 7; do printf "\e[4${c}m    \e[0m"; done
    printf "\n"
}

# ── Separator ──
sep() { printf "  ${DIM}\e[36m$(printf '─%.0s' $(seq 1 42))${NC}\n"; }

# ── Main ──
main() {
    get_mem_vals
    get_swap_vals
    get_disk_vals

    clear
    echo
    print_logo
    sep

    print_info "User"      "$(get_user)"
    print_info "OS"         "$(get_os)"
    print_info "Kernel"    "$(get_kernel)  [$(get_arch)]"
    print_info "Shell"     "$(get_shell)"
    print_info "Uptime"    "$(get_uptime)"
    print_info "Pachete"   "$(get_pkgs)"
    print_info "IP"         "$(get_ip)"

    sep

    print_info "CPU"        "$(get_cpu)"
    print_info "Nuclee"    "$(get_cores)"
    print_info "Load"      "$(get_load)  (1m 5m 15m)"

    sep

    print_bar  "RAM:"       $MU $MT
    printf "  ${DIM}\e[37m%-14s ${YELLOW}%d / %d MB${NC}\n" "" "$MU" "$MT"

    if [ "$ST" -gt 0 ]; then
        print_bar "Swap:"   $SU $ST
        printf "  ${DIM}\e[37m%-14s ${YELLOW}%d / %d MB${NC}\n" "" "$SU" "$ST"
    else
        print_info "Swap:"  "dezactivat"
    fi

    print_bar  "Disk /:"    "${DU:-0}" "${DT:-1}"
    printf "  ${DIM}\e[37m%-14s ${YELLOW}%sG / %sG${NC}\n" "" "$DU" "$DT"

    sep
    print_colors
    
}

main
