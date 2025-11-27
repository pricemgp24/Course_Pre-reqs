#!/bin/bash

echo "=== Nmap Command Builder ==="

# Prompt helper
prompt() {
    local message=$1
    local default=$2
    read -p "$message [$default]: " input
    echo "${input:-$default}"
}

# Step 1: Target
target=$(prompt "Enter target IP or domain (e.g., 192.168.1.1 or scanme.nmap.org)" "")

# Step 2: Ports (custom input or fallback menu)
echo ""
echo "Enter ports to scan (e.g., 22,80,443 or 1000-2000)."
echo "Or press ENTER to choose from predefined options:"
custom_ports=$(prompt "Ports" "")

if [[ -z "$custom_ports" ]]; then
    echo ""
    echo "Select a scan range:"
    echo "1) Default ports (1-1000)"
    echo "2) Common ports (Nmap default - no -p flag)"
    echo "3) Full port scan (1-65535)"
    read -p "Choose option [1]: " port_choice
    port_choice=${port_choice:-1}

    case "$port_choice" in
        2) ports="";;
        3) ports="1-65535";;
        *) ports="1-1000";;
    esac
else
    ports="$custom_ports"
fi

# Step 3: Scan Type
echo ""
echo "Choose scan type:"
echo "1) SYN Scan (-sS) [default]"
echo "2) TCP Connect (-sT)"
echo "3) UDP Scan (-sU)"
echo "4) Ping Scan (-sn)"
scan_choice=$(prompt "Scan type" "1")

case "$scan_choice" in
    2) scan_flag="-sT" ;;
    3) scan_flag="-sU" ;;
    4) scan_flag="-sn" ;;
    *) scan_flag="-sS" ;;
esac

# Step 4: OS Detection
os_input=$(prompt "Enable OS detection? (y/n)" "n")
[[ "$os_input" =~ ^[Yy]$ ]] && os_flag="-O" || os_flag=""

# Step 5: Service Version Detection
svc_input=$(prompt "Enable service version detection? (y/n)" "n")
[[ "$svc_input" =~ ^[Yy]$ ]] && svc_flag="-sV" || svc_flag=""

# Step 6: Output
output_file=$(prompt "Save output to file? Enter filename or leave blank" "")
[[ -n "$output_file" ]] && output_flag="-oN $output_file" || output_flag=""

# Handle port flag construction
if [[ -n "$ports" ]]; then
    port_flag="-p $ports"
else
    port_flag=""
fi

# Build full command
nmap_command="nmap $scan_flag $port_flag $os_flag $svc_flag $output_flag --open $target"

# Display and confirm
echo ""
echo "Final Nmap command:"
echo "  $nmap_command"
read -p "Run this command? (y/n) [n]: " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo ""
    echo "[+] Running scan..."
    eval $nmap_command
else
    echo "[-] Command cancelled."
fi