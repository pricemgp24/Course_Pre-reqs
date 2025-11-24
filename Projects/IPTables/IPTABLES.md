sudo iptables -L OUTPUT -n --line-numbers -v
    8  sudo iptables -R OUTPUT 4 -p tcp -d 172.16.52.20 -j ACCEPT
    9  sudo iptables -L --line-numbers
   10  curl http://172.16.52.20/FW_flag2.txt
   11  sudo iptables -L --line-numbers
   12  sudo iptables -R INPUT 3 -p tcp -s localhost -d localhost --dport 80  -j ACCEPT
   13  sudo iptables -R INPUT 3 -p tcp -s 127.0.0.1 -d 127.0.0.1 --dport 80  -j ACCEPT
   14  curl http://localhost/FW_flag3.txt
   15  sudo iptables -L -n -v
   16  sudo iptables -R INPUT 3 -p tcp -s localhost -d localhost --dport 80  -j ACCEPT
   17  sudo iptables -I OUTPUT 1 -p tcp -d 127.0.0.1 --dport 80   -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT


# See clean numbering
iptables -L INPUT -n --line-numbers

# Allow HTTP from Kali **before** the DROP
iptables -I INPUT 1 -p tcp -s 192.168.45.236 --dport 80 -m conntrack --ctstate NEW -j ACCEPT

# (Optional) if you also need Kali to query this box’s DNS:
iptables -I INPUT 2 -p udp -s 192.168.45.236 --dport 53 -j ACCEPT
iptables -I INPUT 3 -p tcp -s 192.168.45.236 --dport 53 -j ACCEPT
