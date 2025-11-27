#### How to SSH correctly
    ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" learner@192.168.50.52

    sudo updatedb
    locate universal.ovpn

#### Living Off the Land Binaries (LOLBins) / Living Off the Land Binaries and Scripts (LOLBAS)

##### DNS Enumeration (Summary)

DNS translates domain names into IP addresses and is a key source of information during reconnaissance. Each domain exposes multiple record types that can reveal infrastructure details:

- A / AAAA – IPv4 / IPv6 address of a hostname  
- NS – Authoritative nameservers  
- MX – Mail servers and their delivery priority  
- PTR – Reverse lookup mapping IP → hostname  
- CNAME – Aliases to other hostnames  
- TXT – Arbitrary text (often verification or metadata)

Basic Enumeration (Linux – host):
    host www.example.com          # A record
    host -t mx example.com        # MX records
    host -t txt example.com       # TXT records

Bruteforcing Subdomains

Create a small wordlist:
    cat list.txt
    www
    mail
    ftp
    router

Forward brute-force:
    for h in $(cat list.txt); do host $h.example.com; done

Reverse lookup brute-force:
    for ip in $(seq 200 254); do host 51.222.169.$ip; done | grep -v "not found"

Automated Tools

DNSRecon:
    dnsrecon -d example.com -t std                # Standard enumeration
    dnsrecon -d example.com -D list.txt -t brt    # Brute force hostnames

DNSEnum:
    dnsenum example.com

These tools automatically discover NS, MX, A, CNAME, TXT, and additional subdomains, and can also help identify useful reverse-lookup ranges.

Windows Enumeration (nslookup):
    nslookup mail.example.com                            # Simple A-record query
    nslookup -type=TXT info.example.com 192.168.1.1      # Query TXT records on a specific DNS server