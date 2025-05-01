#!/bin/bash

# Nmap Scanner

set -e

# Function to validate an IP address
validate_ip() {
  local ip=$1
  local valid_regex='^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$'
  [[ $ip =~ $valid_regex ]]
}

echo "Nmap Scanner Tool"
echo "----------------------------------------"
echo ""

# Ask for IP input
while true; do
  read -p "Enter a valid target IP address: " target_ip
  if validate_ip "$target_ip"; then
    break
  else
    # Invalid IP, prompt again
    echo "Invalid IP. Please enter a valid IPv4 address (e.g., 192.168.1.1)"
  fi
done

# Optional port input
read -p "Enter ports to scan (e.g., 22,80) or press Enter to skip: " target_ports

# Timing options (T0–T5)
echo ""
echo "Timing Options:"
echo "T0 - Paranoid     T3 - Normal (default)"
echo "T1 - Sneaky       T4 - Aggressive"
echo "T2 - Polite       T5 - Insane"
read -p "Choose timing template (T0–T5), default is T3: " timing_option
timing_option=${timing_option:-T3}

# Show scan options
echo ""
echo "Choose the type of scan to perform:"
echo "1) Basic scan"
echo "2) Version detection (-sV)"
echo "3) OS detection (-O, requires root)"
echo "4) Aggressive scan (-A, requires root)"
echo "5) Ping sweep (-sn)"
read -p "Enter option (1–5): " scan_choice

# Build base Nmap command
port_flag=""
[[ -n $target_ports ]] && port_flag="-p $target_ports"

# Define the scan command
case $scan_choice in
  1)
    scan_cmd="nmap $port_flag -$timing_option $target_ip"
    ;;
  2)
    scan_cmd="nmap -sV $port_flag -$timing_option $target_ip"
    ;;
  3)
    scan_cmd="nmap -O $port_flag -$timing_option $target_ip"
    requires_root=true
    ;;
  4)
    scan_cmd="nmap -A $port_flag -$timing_option $target_ip"
    requires_root=true
    ;;
  5)
    scan_cmd="nmap -sn $target_ip"
    ;;
  *)
    echo "Invalid option. Exiting."
    exit 1
    ;;
esac

# If root is required, prompt to use sudo
if [[ $requires_root == true && $EUID -ne 0 ]]; then
  # Check if user is root
  read -p "This scan requires root. Run with sudo? (y/n): " use_sudo
  if [[ $use_sudo =~ ^[Yy]$ ]]; then
    # Run with sudo
    scan_cmd="sudo $scan_cmd"
  else
    # Exit without sudo
    echo "Cannot run scan without root. Exiting."
    exit 1
  fi
fi

# Safe output file name
safe_ip=$(echo "$target_ip" | tr '.' '_')
output_file="scan_${safe_ip}_opt${scan_choice}.txt"
echo ""

# Run the scan and save output
echo "Running: $scan_cmd"
$scan_cmd | tee "$output_file"
echo ""

echo "Scan complete. Output saved to: $output_file"
