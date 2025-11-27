# **Tcpdump: A Practical Guide**

**Tcpdump** is the world's premier network analysis tool—combining both power and simplicity into a single command-line interface. This guide will show you how to use it.

`tcpdump` is a powerful command-line packet analyzer. It allows you to capture and inspect network traffic in real-time. This tool is invaluable for network administrators, security professionals, and anyone who needs to understand network behavior.

In this tutorial, we'll explore **50 practical examples** of using `tcpdump`. These examples will cover a wide range of use cases—from basic traffic capture to advanced filtering and analysis.

---

## **Basic Syntax**

The basic syntax of `tcpdump` is:

```bash
tcpdump [options] [expression]
```

- **options**: Modify the behavior of tcpdump, such as specifying the interface to capture on or the output format.
- **expression**: Defines what kind of traffic to capture—hostnames, IP addresses, ports, protocols, and other criteria.

---

## **Capturing Traffic on an Interface**

To capture all traffic on a specific interface, use the `-i` flag:

```bash
tcpdump -i eth0
```

To list all available interfaces:

```bash
tcpdump -D
```

---

## **Capturing Traffic to/from a Specific Host**

```bash
tcpdump host 192.168.1.100
```

---

## **Capturing Traffic on a Specific Port**

```bash
tcpdump port 80
```

---

## **Combining Filters**

```bash
tcpdump host 192.168.1.100 and port 80
```

```bash
tcpdump src host 192.168.1.100 and \( port 80 or port 443 \)
```

---

## **Advanced Filtering**

### **By Protocol**

```bash
tcpdump tcp
tcpdump udp
tcpdump icmp
```

### **By Source or Destination**

```bash
tcpdump src host 192.168.1.100
tcpdump dst port 443
```

### **By Network**

```bash
tcpdump net 192.168.1.0/24
tcpdump src net 192.168.1.0/24
tcpdump dst net 192.168.1.0/24
```

---

## **Saving Captured Traffic to a File**

```bash
tcpdump -w capture.pcap -i eth0
```

---

## **Reading Captured Traffic from a File**

```bash
tcpdump -r capture.pcap
```

---

## **Verbosity Options**

- `-v`: Verbose output
- `-vv`: More verbose
- `-vvv`: Most verbose

Example:

```bash
tcpdump -vv -i eth0
```

---

## **50 Tcpdump Examples**

```bash
tcpdump -i eth0
tcpdump -i wlan0
tcpdump host 192.168.1.100
tcpdump host example.com
tcpdump port 80
tcpdump port 443
tcpdump port 22
tcpdump port 21
tcpdump port 25
tcpdump port 53
tcpdump src host 192.168.1.100
tcpdump dst host 192.168.1.100
tcpdump src port 80
tcpdump dst port 443
tcpdump tcp
tcpdump udp
tcpdump icmp
tcpdump net 192.168.1.0/24
tcpdump src net 192.168.1.0/24
tcpdump dst net 192.168.1.0/24
tcpdump dst host 192.168.1.100 and dst port 80
tcpdump src host 192.168.1.100 and src port 443
tcpdump host 192.168.1.100 and \( port 80 or port 443 \)
tcpdump not icmp
tcpdump not port 80
tcpdump 'tcp[tcpflags] & tcp-syn != 0'
tcpdump 'tcp[tcpflags] & tcp-ack != 0'
tcpdump 'tcp[tcpflags] & tcp-rst != 0'
tcpdump 'tcp[tcpflags] & tcp-fin != 0'
tcpdump 'tcp[tcpflags] & tcp-urg != 0'
tcpdump 'tcp[tcpflags] & tcp-push != 0'
tcpdump 'tcp[tcpflags] = 0x01'
tcpdump 'tcp[tcpflags] = 0x00'
tcpdump 'tcp[tcpflags] = 0x12'
tcpdump 'tcp[tcpflags] = 0x14'
tcpdump 'tcp[tcpflags] = 0x11'
tcpdump 'tcp[tcpflags] = 0x18'
tcpdump 'ip[6:2] & 0x1fff != 0'
tcpdump 'ip[8] = 128'
tcpdump 'ip[1] & 0xfc >> 2 = 46'
tcpdump 'ip[1] & 0x03 = 3'
tcpdump 'tcp[4:4] = 12345678'
tcpdump 'tcp[8:4] = 87654321'
tcpdump 'tcp[0:2] > 1023 and tcp[0:2] < 65536'
tcpdump 'tcp[2:2] > 1023 and tcp[2:2] < 65536'
```

These examples should provide a solid foundation for using `tcpdump` to analyze network traffic.
