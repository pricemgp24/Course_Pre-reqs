tcpip header
tcpdump is the world's premier network analysis tool—combining both power and simplicity into a single command-line interface. This guide will show you how to use it.

tcpdump is a powerful command-line packet analyzer. It allows you to capture and inspect network traffic in real-time. This tool is invaluable for network administrators, security professionals, and anyone who needs to understand network behavior.

In this tutorial, we'll explore 50 practical examples of using tcpdump. These examples will cover a wide range of use cases, from basic traffic capture to advanced filtering and analysis.

basic syntax ​

The basic syntax of tcpdump is:


tcpdump [options] [expression]
1
options: Modify the behavior of tcpdump, such as specifying the interface to capture on or the output format.
expression: Defines what kind of traffic to capture. This is where you specify hostnames, IP addresses, ports, protocols, and other criteria.
capturing traffic on an interface ​

To capture all traffic on a specific interface, use the -i flag followed by the interface name. For example, to capture traffic on the eth0 interface:


tcpdump -i eth0
1
To see a list of all available interfaces, use the command:


tcpdump -D
1
capturing traffic to/from a specific host ​

To capture traffic to or from a specific host, use the host keyword followed by the hostname or IP address:


tcpdump host 192.168.1.100
1
This will capture all traffic to and from the host with the IP address 192.168.1.100.

capturing traffic on a specific port ​

To capture traffic on a specific port, use the port keyword followed by the port number:


tcpdump port 80
1
This will capture all traffic on port 80 (HTTP).

combining filters ​

You can combine filters using and, or, and not operators. For example, to capture all traffic to or from host 192.168.1.100 on port 80, use:


tcpdump host 192.168.1.100 and port 80
1
To capture traffic from 192.168.1.100 on either port 80 or 443, use:


tcpdump src host 192.168.1.100 and \( port 80 or port 443 \)
1
advanced filtering ​

filtering by protocol ​

To filter by protocol, use the ip, tcp, udp, or other protocol keywords. For example, to capture only TCP traffic:


tcpdump tcp
1
To capture only UDP traffic:


tcpdump udp
1
filtering by source or destination ​

To filter by source or destination host or port, use the src or dst keywords:


tcpdump src host 192.168.1.100
1
This will capture all traffic from the host 192.168.1.100.


tcpdump dst port 443
1
This will capture all traffic destined for port 443.

filtering by network ​

To capture traffic within a specific network, use the net keyword:


tcpdump net 192.168.1.0/24
1
This will capture all traffic within the 192.168.1.0/24 network.

saving captured traffic to a file ​

To save captured traffic to a file, use the -w flag followed by the filename:


tcpdump -w capture.pcap -i eth0
1
This will save all captured traffic on the eth0 interface to the file capture.pcap.

You can later analyze this file using tcpdump or another packet analyzer like Wireshark.

reading captured traffic from a file ​

To read captured traffic from a file, use the -r flag followed by the filename:


tcpdump -r capture.pcap
1
This will read and display the traffic from the file capture.pcap.

verbosity ​

You can control the verbosity of tcpdump output using the -v, -vv, or -vvv flags.

-v: Verbose output.
-vv: More verbose output.
-vvv: Most verbose output.
For example:

tcpdump -vv -i eth0
1
50 tcpdump examples ​

Here are 50 tcpdump examples to help you isolate traffic in various situations:

Capture all traffic on interface eth0:

tcpdump -i eth0
1
Capture all traffic on interface wlan0:

tcpdump -i wlan0
1
Capture traffic to or from host 192.168.1.100:

tcpdump host 192.168.1.100
1
Capture traffic to or from host example.com:

tcpdump host example.com
1
Capture traffic on port 80 (HTTP):

tcpdump port 80
1
Capture traffic on port 443 (HTTPS):

tcpdump port 443
1
Capture traffic on port 22 (SSH):

tcpdump port 22
1
Capture traffic on port 21 (FTP):

tcpdump port 21
1
Capture traffic on port 25 (SMTP):

tcpdump port 25
1
Capture traffic on port 53 (DNS):

tcpdump port 53
1
Capture traffic from host 192.168.1.100:

tcpdump src host 192.168.1.100
1
Capture traffic to host 192.168.1.100:

tcpdump dst host 192.168.1.100
1
Capture traffic from port 80:

tcpdump src port 80
1
Capture traffic to port 443:

tcpdump dst port 443
1
Capture all TCP traffic:

tcpdump tcp
1
Capture all UDP traffic:

tcpdump udp
1
Capture all ICMP traffic:

tcpdump icmp
1
Capture traffic to or from network 192.168.1.0/24:

tcpdump net 192.168.1.0/24
1
Capture traffic from network 192.168.1.0/24:

tcpdump src net 192.168.1.0/24
1
Capture traffic to network 192.168.1.0/24:

tcpdump dst net 192.168.1.0/24
1
Capture traffic to host 192.168.1.100 on port 80:

tcpdump dst host 192.168.1.100 and dst port 80
1
Capture traffic from host 192.168.1.100 on port 443:

tcpdump src host 192.168.1.100 and src port 443
1
Capture traffic to or from host 192.168.1.100 on port 80 or 443:

tcpdump host 192.168.1.100 and \( port 80 or port 443 \)
1
Capture all traffic except ICMP:

tcpdump not icmp
1
Capture all traffic except port 80:

tcpdump not port 80
1
Capture traffic with a specific TCP flag (SYN):

tcpdump 'tcp[tcpflags] & tcp-syn != 0'
1
Capture traffic with a specific TCP flag (ACK):

tcpdump 'tcp[tcpflags] & tcp-ack != 0'
1
Capture traffic with a specific TCP flag (RST):

tcpdump 'tcp[tcpflags] & tcp-rst != 0'
1
Capture traffic with a specific TCP flag (FIN):

tcpdump 'tcp[tcpflags] & tcp-fin != 0'
1
Capture traffic with a specific TCP flag (URG):

tcpdump 'tcp[tcpflags] & tcp-urg != 0'
1
Capture traffic with a specific TCP flag (PSH):

tcpdump 'tcp[tcpflags] & tcp-push != 0'
1
Capture traffic with a specific TCP flag (ALL):

tcpdump 'tcp[tcpflags] = 0x01'
1
Capture traffic with a specific TCP flag (NONE):

tcpdump 'tcp[tcpflags] = 0x00'
1
Capture traffic with a specific TCP flag (SYN/ACK):

tcpdump 'tcp[tcpflags] = 0x12'
1
Capture traffic with a specific TCP flag (SYN/RST):

tcpdump 'tcp[tcpflags] = 0x14'
1
Capture traffic with a specific TCP flag (SYN/FIN):

tcpdump 'tcp[tcpflags] = 0x11'
1
Capture traffic with a specific TCP flag (PSH/ACK):

tcpdump 'tcp[tcpflags] = 0x18'
1
Capture traffic with a specific IP fragment offset:

tcpdump 'ip[6:2] & 0x1fff != 0'
1
Capture traffic with a specific IP TTL:

tcpdump 'ip[8] = 128'
1
Capture traffic with a specific IP DSCP:

tcpdump 'ip[1] & 0xfc >> 2 = 46'
1
Capture traffic with a specific IP ECN:

tcpdump 'ip[1] & 0x03 = 3'
1
Capture traffic with a specific TCP sequence number:

tcpdump 'tcp[4:4] = 12345678'
1
Capture traffic with a specific TCP acknowledgement number:

tcpdump 'tcp[8:4] = 87654321'
1
Capture traffic with a specific TCP source port range:

tcpdump 'tcp[0:2] > 1023 and tcp[0:2] < 65536'
1
Capture traffic with a specific TCP destination port range:

tcpdump 'tcp[2:2] > 1023 and tcp[2:2] < 65536'
1
These examples should provide a solid foundation for using tcpdump to analyze network traffic.