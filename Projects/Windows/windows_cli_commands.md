# Windows Command Line Commands

Here are useful Windows CLI commands and their purposes, distilled from the freeCodeCamp article:

---

## 🔧 System and Admin Access

- `powershell start cmd -v runAs` — Run Command Prompt as Administrator
- `driverquery` — List all installed drivers
- `systeminfo` — Show detailed system information
- `set` — Display environment variables
- `prompt prompt_name $G` — Change default prompt text
- `title window-title-name` — Change Command Prompt window title
- `ver` — Show OS version
- `sfc /scannow` — System file checker to scan and repair
- `dism` — Deployment Image Servicing and Management tool

---

## 📁 File and Directory Management

- `dir` — List directory contents
- `cd` or `chdir` — Change directory
- `mkdir folder_name` — Create a directory
- `rmdir folder_name` — Remove an empty directory
- `del filename` — Delete a file
- `attrib +h +s +r folder_name` — Hide a folder
- `attrib -h -s -r folder_name` — Unhide a folder
- `move file target_folder` — Move a file or folder
- `ren file.ext newname.ext` — Rename a file
- `cls` — Clear the command line
- `exit` — Exit the command line

---

## 🌐 Network and Internet Tools

- `ping domain.com` — Test network latency and connectivity
- `ipconfig` — Show IP settings
- `ipconfig /release`, `/renew`, `/flushdns` — Manage IP and DNS
- `netstat -an` — Show open ports and connection states
- `for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @echo %j | findstr -i -v echo | netsh wlan show profiles %j key=clear` — Show all saved Wi-Fi passwords

---

## 🔒 Security and Encryption

- `cipher` — Wipe free space and encrypt data

---

## 📄 File Utilities

- `clip` — Copy command output to clipboard (e.g., `dir | clip`)
- `fc file1 file2` — Compare two files
- `echo message` — Print message to screen
- `echo message > file.txt` — Write message to a file
- `more file.txt` — View file content one page at a time

---

## ⚙️ Power Management

- `powercfg` — Manage power settings
- `powercfg /energy` — Generate power efficiency report

---

## 🗓 Date and Time

- `date` — Show/change date
- `time` — Show/change time

---

## 🌳 Misc

- `tree` — Display directory tree
- `tasklist` — List running tasks
- `taskkill /IM process.exe /F` — Kill a process
- `color 2` — Change terminal text color (green)
- `start https://example.com` — Open a website
- `CTRL + C` — Stop command execution
- `-help` — Show help for a command (e.g., `powercfg -help`)
- `shutdown /r` — Restart computer

---

> ⚠️ Use these commands carefully. Some affect system configuration and may require administrative privileges.
