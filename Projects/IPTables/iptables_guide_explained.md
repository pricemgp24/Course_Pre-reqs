
# An In-Depth Guide to iptables, the Linux Firewall

## Introduction

The Linux kernel comes with a packet filtering framework named **netfilter**. It allows you to allow, drop, and modify traffic leaving in and out of a system. The `iptables` tool builds upon this functionality to provide a powerful firewall.

## How does iptables work?

`iptables` is a command-line interface to netfilter. Packet filtering is organized into **tables**, **chains**, and **targets**.

### Tables

- **filter**: Default table used for packet filtering.
- **mangle**: Used for specialized packet alteration.
- **nat**: Used for Network Address Translation.
- **raw**: Used to exempt packets from connection tracking.
- **security**: SELinux policies.

### Chains

- **PREROUTING**: Before routing decision.
- **INPUT**: For packets destined to local sockets.
- **FORWARD**: For packets being routed through.
- **OUTPUT**: For locally-generated packets.
- **POSTROUTING**: After routing decision.

## Basic Usage

### Block an IP
```bash
> This rule appends a rule to the INPUT chain to block or reject packets from a specific source IP.
iptables -A INPUT -s 59.45.175.62 -j REJECT
```

### Block an IP Range
```bash
> This rule appends a rule to the INPUT chain to block or reject packets from a specific source IP.
iptables -A INPUT -s 59.45.175.0/24 -j REJECT
```

### Drop Output to an IP
```bash
> This rule appends a rule to the OUTPUT chain to block outgoing packets to a specific destination IP.
iptables -A OUTPUT -d 31.13.78.35 -j DROP
```

### List Rules
```bash
> This command lists the current rules in the specified chain.
iptables -L --line-numbers
> This command lists the current rules in the specified chain.
iptables -L -n --line-numbers
```

### Delete Rules
```bash
> This deletes a specific rule from a chain either by match or line number.
iptables -D INPUT -s 221.194.47.0/24 -j REJECT
> This deletes a specific rule from a chain either by match or line number.
iptables -D INPUT 2
```

### Flush Chain
```bash
> This flushes all rules from a specified chain.
iptables -F INPUT
```

### Insert Rule
```bash
> This inserts a new rule at a specific position in the chain.
iptables -I INPUT 1 -s 59.45.175.10 -j ACCEPT
```

### Replace Rule
```bash
> This replaces a rule in a chain at a specific position.
iptables -R INPUT 1 -s 59.45.175.10 -j ACCEPT
```

### Protocol Matching
```bash
iptables -A INPUT -p tcp -j DROP
> This rule filters packets by TCP protocol and destination port.
iptables -A INPUT -p tcp -m tcp --dport 22 -j DROP
> This rule filters packets by TCP protocol and destination port.
iptables -A INPUT -p tcp -m multiport --dports 22,5901 -j DROP
```

### ICMP Matching
```bash
iptables -A INPUT -p icmp -m icmp --icmp-type 17 -j DROP
```

### Connection Tracking
```bash
> Allows packets that are part of an existing or related connection.
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
> Drops packets that are not associated with any valid connection state.
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
```

### Default Policy
```bash
> Sets the default policy for a chain (ACCEPT or DROP).
iptables -P INPUT DROP
```

### Match Interface
```bash
> Accepts traffic from the loopback interface (local traffic).
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o wlan0 -d 121.18.238.0/29 -j DROP
```

### Negate Condition
```bash
> This rule filters packets by TCP protocol and destination port.
iptables -A INPUT -p tcp -m multiport ! --dports 22,80,443 -j DROP
```

### Drop Invalid TCP
```bash
iptables -A INPUT -p tcp -m tcp --tcp-flags ALL FIN,PSH,URG -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -j DROP
```

### Rate Limit
```bash
> Uses the limit module to rate-limit how many packets are accepted.
iptables -A INPUT -p icmp -m limit --limit 1/sec --limit-burst 1 -j ACCEPT
```

### Per-IP Limit (recent module)
```bash
> This rule filters packets by TCP protocol and destination port.
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set --name SSHLIMIT --rsource
> This rule filters packets by TCP protocol and destination port.
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 180 --hitcount 5 --name SSHLIMIT --rsource -j DROP
```

### Owner Module
```bash
> This rule appends a rule to the OUTPUT chain to block outgoing packets to a specific destination IP.
iptables -A OUTPUT -d 31.13.78.35 -m owner --uid-owner bobby -j DROP
```

### Custom Chain
```bash
> Creates a new custom chain for organizing rules.
iptables -N ssh-rules
iptables -A ssh-rules -s 18.130.0.0/16 -j ACCEPT
iptables -A ssh-rules -s 18.11.0.0/16 -j ACCEPT
iptables -A ssh-rules -j DROP
> This rule filters packets by TCP protocol and destination port.
iptables -A INPUT -p tcp --dport 22 -j ssh-rules
> Deletes a custom chain. It must be empty and unused first.
iptables -X ssh-rules
```

### Logging Packets
```bash
> Logs matching packets to the system logs for inspection or auditing.
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN FIN,SYN -j LOG --log-prefix="iptables: "
```

### Save & Restore
```bash
> Saves the current iptables configuration to a file.
iptables-save > iptables.rules
> Restores the iptables configuration from a previously saved file.
iptables-restore < iptables.rules
```

### Make Persistent
```bash
# RHEL/CentOS
sudo yum install iptables-services

# Debian/Ubuntu
sudo apt install iptables-persistent
```

---

Adapted from [booleanworld.com](https://booleanworld.com) by Supriyo Biswas.
