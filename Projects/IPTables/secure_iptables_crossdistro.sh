#!/bin/bash

# ===========================================
# IPTABLES SECURE CONFIGURATION SCRIPT
# Compatible with Rocky Linux, Raspbian, Kali Linux
# ===========================================

# ----------------------
# 1. Install requirements
# ----------------------
sudo apt update
sudo apt install iptables-persistent -y
sudo netfilter-persistent save
sudo systemctl enable netfilter-persistent

# ----------------------
# 2. Flush existing rules
# ----------------------
iptables -F
iptables -X
iptables -t nat -F

# ----------------------
# 2. Allow SSH first (for remote safety)
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# ----------------------
# 3. Allow established/related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# ----------------------
# 4. Allow web traffic
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# ----------------------
# 5. Allow ICMP (ping)
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

# ----------------------
# 6. Allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# ----------------------
# 7. Set default DROP policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# ----------------------
# 8. Enable IP forwarding (optional)
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# ----------------------
# 9. Save rules persistently based on distro
if [ -x "$(command -v netfilter-persistent)" ]; then
    echo "[*] Saving iptables rules with netfilter-persistent"
    netfilter-persistent save
    systemctl enable netfilter-persistent
elif [ -f /etc/redhat-release ]; then
    echo "[*] Saving iptables rules with iptables-services (Rocky/RHEL)"
    service iptables save
    systemctl enable iptables
else
    echo "[!] Unknown system: please manually ensure rules persist after reboot."
fi

echo "✅ iptables configuration complete and persistent."
