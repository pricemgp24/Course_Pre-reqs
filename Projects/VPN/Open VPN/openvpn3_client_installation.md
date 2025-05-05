# Tutorial: Learn to Install and Control the OpenVPN 3 Client

## OpenVPN 3 Client for Linux

> This document is a reference for the OpenVPN 3 Linux client. CloudConnexa Connector for Linux uses OpenVPN 3. For more information, refer to the [Community Wiki](https://github.com/OpenVPN/openvpn3-linux).

### Supported Distributions

| Distribution | Release | Codename   | Architectures             |
|--------------|---------|------------|---------------------------|
| Debian       | 11      | bullseye   | amd64, arm64 (tech preview) |
| Debian       | 12      | bookworm   | amd64, arm64 (tech preview) |
| Ubuntu       | 20.04   | focal      | amd64, arm64 (tech preview) |
| Ubuntu       | 22.04   | jammy      | amd64, arm64 (tech preview) |
| Ubuntu       | 24.04   | noble      | amd64, arm64 (tech preview) |
| Fedora       | -       | -          | Recent stable releases     |
| RHEL         | 8, 9    | -          | aarch64, ppc64le*, s390x*, x86_64 |

\* Only via Fedora Copr repositories (tech preview).

---

## Installation Instructions

### Debian/Ubuntu

```sh
sudo mkdir -p /etc/apt/keyrings && \
curl -fsSL https://packages.openvpn.net/packages-repo.gpg | sudo tee /etc/apt/keyrings/openvpn.asc

DISTRO=$(lsb_release -c -s)

echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $DISTRO main" | \
sudo tee /etc/apt/sources.list.d/openvpn-packages.list

sudo apt update
sudo apt install openvpn3
```

---

### RHEL/AlmaLinux/Rocky Linux

#### RHEL 8

```sh
sudo yum localinstall https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo subscription-manager repos --enable "codeready-builder-for-rhel-8-$(/bin/arch)-rpms"
```

#### RHEL 9

```sh
sudo yum localinstall https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

#### AlmaLinux / Rocky Linux

```sh
sudo yum install epel-release
sudo yum config-manager --set-enabled powertools
```

#### Install OpenVPN 3

```sh
sudo yum install -y https://packages.openvpn.net/openvpn-openvpn3-epel-repo-1-1.noarch.rpm
sudo yum install openvpn3-client
```

---

## Using `.ovpn` Profile

### Import and Set Up

```sh
openvpn3 config-import --config /path/to/profile.ovpn --name CloudConnexa --persistent
openvpn3 config-acl --show --lock-down true --grant root --config CloudConnexa
sudo systemctl enable --now openvpn3-session@CloudConnexa.service
```

---

## Session Management

### Start (one-shot)
```sh
openvpn3 session-start --config /path/to/config.ovpn
```

### Start (from imported)
```sh
openvpn3 session-start --config CloudConnexa
```

### List profiles
```sh
openvpn3 configs-list
```

### List sessions
```sh
openvpn3 sessions-list
```

### Restart session
```sh
openvpn3 session-manage --config CloudConnexa --restart
```

### Disconnect session
```sh
openvpn3 session-manage --session-path /net/openvpn/v3/sessions/... --disconnect
```

### Session statistics
```sh
openvpn3 session-stats --config CloudConnexa
```

### Logs
```sh
openvpn3 log --config CloudConnexa --log-level 6
```

---

## Autoload Profile Change (RHEL-7 only)

```sh
sudo openvpn3 sessions-list
sudo openvpn3 session-manage --session-path <PATH> --disconnect
sudo openvpn3 configs-list
sudo openvpn3 config-remove --config "YOUR_CONFIG_NAME"
sudo nano /etc/openvpn3/autoload/Connector.conf
# Replace contents
sudo openvpn3 config-import --config /etc/openvpn3/autoload/Connector.conf --name "NEW_CONFIG_NAME"
sudo openvpn3 session-start --config "NEW_CONFIG_NAME"
sudo reboot
```
