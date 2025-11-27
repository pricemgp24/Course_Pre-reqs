#!/usr/bin/env python3
import subprocess

def prompt(label, default=""):
    val = input(f"{label} [{default}]: ")
    return val.strip() if val.strip() else default

print("=== Nmap Command Builder ===")

# Step 1: Target
target = prompt("Enter target IP or domain (e.g., 192.168.1.1 or scanme.nmap.org)")

# Step 2: Ports
ports = prompt("Enter ports to scan (e.g., 22,80,443 or 1-1000)", "1-1000")

# Step 3: Scan Type
print("\nChoose scan type:")
print("1) SYN Scan (-sS) [default]")
print("2) TCP Connect (-sT)")
print("3) UDP Scan (-sU)")
print("4) Ping Scan (-sn)")
scan_choice = prompt("Scan type", "1")

scan_types = {
    "1": "-sS",
    "2": "-sT",
    "3": "-sU",
    "4": "-sn"
}
scan_flag = scan_types.get(scan_choice, "-sS")

# Step 4: OS Detection?
os_detect = prompt("Enable OS detection? (y/n)", "n").lower() == 'y'
os_flag = "-O" if os_detect else ""

# Step 5: Service Version Detection?
service_detect = prompt("Enable service version detection? (y/n)", "n").lower() == 'y'
svc_flag = "-sV" if service_detect else ""

# Step 6: Output Format
output_file = prompt("Save output to file? Enter filename or leave blank to skip", "")
output_flag = f"-oN {output_file}" if output_file else ""

# Build final command
nmap_command = f"nmap {scan_flag} -p {ports} {os_flag} {svc_flag} {output_flag} {target}".strip()

# Show user and confirm
print(f"\nFinal Nmap command:\n  {nmap_command}")
confirm = prompt("Run this command? (y/n)", "n").lower()

if confirm == 'y':
    print("\n[+] Running scan...\n")
    subprocess.run(nmap_command, shell=True)
else:
    print("[-] Command cancelled.")