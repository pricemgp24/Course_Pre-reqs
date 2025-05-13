#!/bin/bash

# ===========================================
# IPTABLES SECURE REMOTE CONFIGURATION SCRIPT
# For Rocky Linux / Raspbian - Safe for SSH
# ===========================================

# ----------------------
# 1. Flush old rules
# ----------------------
iptables -F                      # Flush all rules in filter table
iptables -X                      # Delete all user-defined chains
iptables -t nat -F               # Flush NAT table

# ----------------------
# 2. Allow SSH access first!
# ----------------------
# Allow new and established SSH connections
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# conntrack explanation:
# -m conntrack: Enables connection tracking module.
# --ctstate: Specifies the connection state.
# NEW: A new connection (e.g., SSH login request).
# ESTABLISHED: Part of an existing connection.

# ----------------------
# 3. Allow Established/Related traffic
# ----------------------
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# RELATED: E.g., FTP data channel or ICMP errors related to existing sessions.

# ----------------------
# 4. Allow web traffic (HTTP/HTTPS)
# ----------------------
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# ----------------------
# 5. Allow ICMP (ping)
# ----------------------
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

# ----------------------
# 6. Allow loopback interface
# ----------------------
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# ----------------------
# 7. Set default policies
# ----------------------
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# ----------------------
# 8. Save configuration
# ----------------------
# Detect OS and save accordingly
if [ -x "$(command -v netfilter-persistent)" ]; then
    netfilter-persistent save
    systemctl enable netfilter-persistent
elif [ -x "$(command -v service)" ]; then
    service iptables save
    systemctl enable iptables
fi

# ----------------------
# 9. Optional: Enable NAT masquerade (edit eth0/eth1 as needed)
# ----------------------
# Uncomment if needed
# echo 1 > /proc/sys/net/ipv4/ip_forward
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
# iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Apply NAT for traffic coming *from 10.10.1.0/24*
# iptables -t nat -A POSTROUTING -s 10.10.1.0/24 -o eth0 -j MASQUERADE

# Allow forwarding from Pi’s subnet to anywhere
# iptables -A FORWARD -s 10.10.1.0/24 -j ACCEPT
# iptables -A FORWARD -d 10.10.1.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
echo "Firewall rules applied successfully."
