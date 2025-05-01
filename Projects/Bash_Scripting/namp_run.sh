#!/bin/bash

set -e

echo "NMAP Tool:" 
echo "----------"

# Strict IPv4 validation (each octet 1–255, no CIDR allowed)
validate_ip() {
  local ip=$1
  local valid_regex='^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?|[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?|[0-9])$'
  [[ $ip =~ $valid_regex ]]
}

# Prompt for IP
while true; do 
    read -p "Input target IP: " nmap_ip
    if validate_ip "$nmap_ip"; then
        break
    else 
        echo "Invalid IP Address. Must be 4 octets, 1–255."
    fi
done

# Safe output file name
safe_ip=$(echo "$nmap_ip" | tr '.' '_')
echo ""

read -p "Enter ports (comma-separated, e.g., 22,80,443), or leave blank for default: " nmap_ports

# Prompt for timing template
echo ""
echo "Nmap Timing Options:"
echo "  T0 - Paranoid (very slow, IDS evasion)"
echo "  T1 - Sneaky"
echo "  T2 - Polite"
echo "  T3 - Normal (default)"
echo "  T4 - Aggressive (faster)"
echo "  T5 - Insane (fastest)"
read -p "Select a timing option (T0–T5, default T3): " nmap_timing
nmap_timing=${nmap_timing:-T3}

# Port option string
port_option=""
if [[ -n $nmap_ports ]]; then
  port_option="-p $nmap_ports"
fi

# Build recommended commands
declare -a commands
commands[1]="nmap $port_option -$nmap_timing $nmap_ip"
commands[2]="nmap -sV $port_option -$nmap_timing $nmap_ip"
commands[3]="nmap -O $port_option -$nmap_timing $nmap_ip"
commands[4]="nmap -A $port_option -$nmap_timing $nmap_ip"
commands[5]="nmap -sS $port_option -$nmap_timing $nmap_ip"
commands[6]="nmap -p- -$nmap_timing $nmap_ip"
commands[7]="nmap -sn $nmap_ip"

# Show command options
echo ""
echo "Recommended Nmap Commands:"
for i in {1..7}; do
  echo "$i) ${commands[$i]}"
done

# Ask user to select one to run
echo ""
read -p "Select a command to run (1–7): " choice

# Validate and run
if [[ "$choice" =~ ^[1-7]$ ]]; then
  selected_cmd="${commands[$choice]}"
  output_file="nmap_${safe_ip}_opt${choice}.txt"
  echo ""
  echo "Running: $selected_cmd"
  echo "Saving output to: $output_file"
  echo "------------------------------------"

  # If choice requires root (3 = -O, 4 = -A) and user is not root
  if [[ "$choice" == "3" || "$choice" == "4" ]]; then
    # Check if user is root
    if [[ $EUID -ne 0 ]]; then
      # Prompt for sudo
      read -p "This scan requires root. Run with sudo? (y/n): " use_sudo
      if [[ "$use_sudo" =~ ^[Yy]$ ]]; then
        # Run with sudo
        sudo bash -c "$selected_cmd | tee './$output_file'"
      else
        # Exit without sudo
        echo "Cannot run OS detection without root. Exiting."
        exit 1
      fi
    else
      # Run without sudo
      eval "$selected_cmd" | tee "./$output_file"
    fi
  else
    # Run without sudo
    eval "$selected_cmd" | tee "./$output_file"
  fi

  echo ""
  echo "Scan complete. Output saved to: $output_file"
else
  # Invalid choice
  echo "Invalid choice. Exiting without running a scan."
fi

