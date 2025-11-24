# PsExec v2.43 - Sysinternals

## Introduction

PsExec is a lightweight telnet-replacement that allows you to execute processes on remote systems without installing client software. It supports full interactivity for console applications and is particularly useful for running command prompts and system tools remotely.

**Author**: Mark Russinovich  
**Published**: April 11, 2023  
**Download**: [PsTools (5 MB)](https://download.sysinternals.com/files/PSTools.zip)

## Installation

Just copy `PsExec` onto your executable path. Typing `psexec` in the command prompt displays its usage syntax.

## Using PsExec

**Basic Syntax**:
```bash
psexec [\\computer[,computer2[,...] | @file]] [-u user [-p psswd]] [-n s] [-r servicename] [-h] [-l] [-s|-e] [-x] [-i [session]] [-c [-f|-v]] [-w directory] [-d] [-<priority>] [-g n] [-a n,n,...] [-accepteula] [-nobanner] cmd [arguments]
```

## Parameters

| Parameter | Description |
|----------|-------------|
| `-a` | Specify CPUs to run the application (e.g., `-a 2,4`). |
| `-c` | Copy the executable to remote system for execution. |
| `-d` | Do not wait for process to terminate (non-interactive). |
| `-e` | Does not load the user profile. |
| `-f` | Copy even if file exists on remote. |
| `-i` | Run program interactively in a specified session. |
| `-h` | Use elevated token on Vista and above. |
| `-l` | Run as limited user. |
| `-n` | Set connection timeout in seconds. |
| `-p` | Password for specified user. |
| `-r` | Remote service name to use. |
| `-s` | Run in the SYSTEM account. |
| `-u` | Specify user name for remote login. |
| `-v` | Only copy file if newer. |
| `-w` | Set working directory on remote. |
| `-x` | Show UI on secure desktop (local only). |
| `-priority` | Set process priority (`low`, `high`, etc.). |
| `@file` | List of computers to execute on. |
| `cmd` | Application to execute. |
| `arguments` | Arguments passed to the command. |
| `-accepteula` | Suppress license dialog. |
| `-nobanner` | Suppress banner and copyright. |

## Examples

```bash
# Interactive prompt on remote machine
psexec -i \\marklap cmd

# Run ipconfig /all remotely
psexec -i \\marklap ipconfig /all

# Copy and run test.exe remotely
psexec -i \\marklap -c test.exe

# Run existing program not in path
psexec -i \\marklap c:\bin\test.exe

# Run Regedit with SYSTEM privileges
psexec -i -d -s c:\windows\regedit.exe

# Run Internet Explorer with limited privileges
psexec -l -d "c:\program files\internet explorer\iexplore.exe"
```

## PsTools Suite

PsExec is part of PsTools - a suite of command-line tools for managing local and remote systems.

**Supported OS**:
- **Client**: Windows 8.1 and higher
- **Server**: Windows Server 2012 and higher

## Resources

- [PsTools Documentation](https://learn.microsoft.com/en-us/sysinternals/downloads/psexec)
- [Administer Remote Computers using PowerShell](https://learn.microsoft.com/en-us/training/modules/administer-remote-computers-powershell/)
- [PsKill - Terminate Processes](https://learn.microsoft.com/en-us/sysinternals/downloads/pskill)