#!/bin/bash

echo "=== Cockpit Firewall & SSH Tunnel Tool ==="

# Prompt for inputs
read -p "Enter SERVER_PORT (default 9090): " SERVER_PORT
SERVER_PORT=${SERVER_PORT:-9090}

read -p "Enter CLIENT_PORT (default 9900): " CLIENT_PORT
CLIENT_PORT=${CLIENT_PORT:-9900}

read -p "Enter SERVER_IP (IP of server to protect / tunnel to): " SERVER_IP
read -p "Enter SSH username on the server: " SSH_USER

# Get local IPs
LOCAL_IPS=$(hostname -I)

function run_firewalld_remote() {
    echo "[+] Running firewalld rules remotely via SSH..."
    ssh ${SSH_USER}@${SERVER_IP} "sudo firewall-cmd --permanent --remove-port=${SERVER_PORT}/tcp || true"
    ssh ${SSH_USER}@${SERVER_IP} "sudo firewall-cmd --permanent --add-rich-rule='rule family=\"ipv4\" port port=\"${SERVER_PORT}\" protocol=\"tcp\" reject'"
    ssh ${SSH_USER}@${SERVER_IP} "sudo firewall-cmd --reload"
    echo "[✔] firewalld rules applied remotely."
}

function run_iptables_remote() {
    echo "Choose iptables blocking mode:"
    echo "1) Block ALL traffic to port ${SERVER_PORT}"
    echo "2) Allow localhost ONLY, block all external"
    read -p "Choice [1 or 2]: " IPT_MODE

    read -s -p "Enter sudo password for ${SSH_USER}@${SERVER_IP}: " SUDOPASS
    echo ""

    if [[ "$IPT_MODE" == "2" ]]; then
        echo "[+] Applying loopback-only rules remotely..."
        ssh ${SSH_USER}@${SERVER_IP} "echo '${SUDOPASS}' | sudo -S iptables -I INPUT -i lo -p tcp --dport ${SERVER_PORT} -j ACCEPT"
        ssh ${SSH_USER}@${SERVER_IP} "echo '${SUDOPASS}' | sudo -S iptables -A INPUT -p tcp --dport ${SERVER_PORT} -j REJECT"
    else
        echo "[+] Blocking all traffic remotely..."
        ssh ${SSH_USER}@${SERVER_IP} "echo '${SUDOPASS}' | sudo -S iptables -A INPUT -p tcp --dport ${SERVER_PORT} -j REJECT"
    fi

    echo "[✔] iptables rules applied remotely."
}

# Check: are we on the server?
if echo "$LOCAL_IPS" | grep -qw "$SERVER_IP"; then
    echo "[+] You are on the SERVER node."

    read -p "Apply firewalld rules locally? (y/n): " FW_LOCAL
    if [[ "$FW_LOCAL" =~ ^[Yy]$ ]]; then
        sudo firewall-cmd --permanent --remove-port=${SERVER_PORT}/tcp 2>/dev/null
        sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' port port='${SERVER_PORT}' protocol='tcp' reject" 
        sudo firewall-cmd --reload
        echo "[✔] firewalld rules applied locally."
    fi

    read -p "Apply iptables rules locally? (y/n): " IPT_LOCAL
    if [[ "$IPT_LOCAL" =~ ^[Yy]$ ]]; then
        run_iptables_remote  # reuse logic for local if needed
    fi
else
    echo "[+] You are on the CLIENT node."

    read -p "Apply firewalld rules on the server via SSH? (y/n): " FW_REMOTE
    if [[ "$FW_REMOTE" =~ ^[Yy]$ ]]; then
        run_firewalld_remote
    fi

    read -p "Apply iptables rules on the server via SSH? (y/n): " IPT_REMOTE
    if [[ "$IPT_REMOTE" =~ ^[Yy]$ ]]; then
        run_iptables_remote
    fi

    echo ""
    echo "[+] Creating SSH tunnel from localhost:${CLIENT_PORT} → ${SERVER_IP}:${SERVER_PORT}"
    echo "Use Ctrl+C to stop the tunnel."
    ssh -L ${CLIENT_PORT}:localhost:${SERVER_PORT} ${SSH_USER}@${SERVER_IP}
fi