# WireGuard Installation Guide (Markdown Version)

```bash
#!/bin/bash

# Installation

# Windows [7, 8.1, 10, 11, 2008R2, 2012R2, 2016, 2019, 2022 – v0.5.3]
# Browse MSIs

# macOS [app store – v1.0.16]

# Ubuntu [module – v1.0.20210606 – out of date & tools – v1.0.20210914]
sudo apt install wireguard

# Android [play store – v1.0.20231018 & direct apk file – v1.0.20231018]
# Download APK File

# iOS [app store – v1.0.16]

# Debian [module – v1.0.20220627 & tools – v1.0.20210914]
apt install wireguard
# Users with Debian releases older than Bullseye should enable backports.

# Fedora [tools – v1.0.20210914]
sudo dnf install wireguard-tools

# Mageia [tools – v1.0.20210914]
sudo urpmi wireguard-tools

# Arch [module – v1.0.20220627 & tools – v1.0.20210914]
sudo pacman -S wireguard-tools
# Users of kernels < 5.6 may also choose wireguard-lts or wireguard-dkms+linux-headers.

# OpenSUSE/SLE [tools – v1.0.20210914]
sudo zypper install wireguard-tools

# Slackware [tools – v1.0.20210914]
sudo slackpkg install wireguard-tools

# Alpine [tools – vunknown – out of date]
# apk add -U wireguard-tools

# Gentoo [module – v1.0.20220627 & tools – v1.0.20210914]
# emerge wireguard-tools

# Exherbo [module – vunknown – out of date & tools – vunknown – out of date]
# cave resolve -x wireguard

# NixOS [module – v1.0.20220627 & tools – vunknown – out of date]
boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
environment.systemPackages = [ pkgs.wireguard pkgs.wireguard-tools ];

# Nix on Darwin [userspace go – vunknown – out of date & tools – vunknown – out of date]
nix-env -iA nixpkgs.wireguard-tools

# OpenWRT [tools – v1.0.20210914]
opkg install wireguard

# Oracle Linux 8 [UEK6 & tools – v1.0.20200827 – out of date]
dnf install oraclelinux-developer-release-el8
dnf config-manager --disable ol8_developer
dnf config-manager --enable ol8_developer_UEKR6
dnf config-manager --save --setopt=ol8_developer_UEKR6.includepkgs='wireguard-tools*'
dnf install wireguard-tools

# Red Hat Enterprise Linux 8
# Method 1
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
sudo yum install kmod-wireguard wireguard-tools

# Method 2
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
sudo yum copr enable jdoss/wireguard
sudo yum install wireguard-dkms wireguard-tools

# CentOS 8
# Method 1
sudo yum install yum-utils epel-release
sudo yum-config-manager --setopt=centosplus.includepkgs="kernel-plus, kernel-plus-*" --setopt=centosplus.enabled=1 --save
sudo sed -e 's/^DEFAULTKERNEL=kernel-core$/DEFAULTKERNEL=kernel-plus-core/' -i /etc/sysconfig/kernel
sudo yum install kernel-plus wireguard-tools
sudo reboot

# Method 2
sudo yum install elrepo-release epel-release
sudo yum install kmod-wireguard wireguard-tools

# Method 3
sudo yum install epel-release
sudo yum config-manager --set-enabled PowerTools
sudo yum copr enable jdoss/wireguard
sudo yum install wireguard-dkms wireguard-tools

# Oracle Linux 7
yum install oraclelinux-developer-release-el7
yum-config-manager --disable ol7_developer
yum-config-manager --enable ol7_developer_UEKR6
yum-config-manager --save --setopt=ol7_developer_UEKR6.includepkgs='wireguard-tools*'
yum install wireguard-tools

# Red Hat Enterprise Linux 7
# Method 1
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
sudo yum install kmod-wireguard wireguard-tools

# Method 2
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo curl -o /etc/yum.repos.d/jdoss-wireguard-epel-7.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
sudo yum install wireguard-dkms wireguard-tools

# CentOS 7
# Method 1
sudo yum install yum-utils epel-release
sudo yum-config-manager --setopt=centosplus.includepkgs=kernel-plus --enablerepo=centosplus --save
sudo sed -e 's/^DEFAULTKERNEL=kernel$/DEFAULTKERNEL=kernel-plus/' -i /etc/sysconfig/kernel
sudo yum install kernel-plus wireguard-tools
sudo reboot

# Method 2
sudo yum install epel-release elrepo-release
sudo yum install yum-plugin-elrepo
sudo yum install kmod-wireguard wireguard-tools

# Method 3
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo curl -o /etc/yum.repos.d/jdoss-wireguard-epel-7.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
sudo yum install wireguard-dkms wireguard-tools

# FreeBSD
pkg install wireguard

# OpenBSD
pkg_add wireguard-tools

# Termux
pkg install wireguard-tools

# Void
xbps-install -S wireguard-tools wireguard-dkms

# Adélie Linux
apk add wireguard-tools wireguard-module

# Source Mage
cast wireguard-tools

# Buildroot
BR2_PACKAGE_WIREGUARD_LINUX_COMPAT=y
BR2_PACKAGE_WIREGUARD_TOOLS=y

# EdgeOS
sudo dpkg -i wireguard-{type}-{version}.deb

# AstLinux
BR2_PACKAGE_WIREGUARD_TOOLS=y
BR2_PACKAGE_WIREGUARD=y

# Milis
mps kur wireguard-tools wireguard-linux-compat

# macOS Homebrew
brew install wireguard-tools

# macOS MacPorts
port install wireguard-tools

# End
```
