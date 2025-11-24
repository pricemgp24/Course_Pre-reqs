#### Windows Basics:
- runas /user:<name> "cmd.exe /k C:\Users\<name>\Desktop\<file.exe>"
##### Getting File Echo to a .txt 
- runas /user:WINDOWS-02\teal "cmd.exe /C (echo particles to particles) ^> \"C:\Users\Offsec\Desktop\Colors\Particles\photons.txt\""
##### Changing Perms on a file User and Group:
- icacls "C:\Users\Offsec\Desktop\Colors\lazerbeams.txt" /grant "WINDOWS-02\WarmColors:(RX)"
- icacls "C:\Users\Offsec\Desktop\Colors\lazerbeams.txt" /grant "Everyone:(R)"
###### Granting Synchronized:
- icacls "C:\Users\Offsec\Desktop\Colors\Chromacity" /grant:r Everyone:(RD,S)
##### Processes
- wmic process where processid=<CHILD_PID> get Name,ProcessId,ParentProcessId
- type "C:\Users\Offsec\Desktop\flag.txt"
- pssuspend -r file.exe < ensure to run -accepteula the first time>
##### Find Programs that have publisher specific
- listdlls -u -v | findstr /i /c:" pid:" /c:"Publisher: Igor Pavlov"
##### Use dir to find information about a DLL
- dir C:\WINDOWS\SYSTEM32\NETAPI32.dll /C
#### Registry
HKEY_CLASSES_ROOT (HKCR): Provides information related to file types and properties. The subkeys under HKCR are often used by shell applications (such as the Command Prompt) and by Component Object Model (COM) applications.

HKEY_CURRENT_CONFIG (HKCC): Provides information related to the hardware configurations upon which the OS is running, specifically in comparison to the default configuration.

HKEY_CURRENT_USER (HKCU): Provides information related to the setting configurations of the current user. Note that the HKCU key and subkeys will be different depending on what user is logged in, including SYSTEM.

HKEY_LOCAL_MACHINE: Provides information about the local machine related to input/output devices, memory, and drivers.

HKEY_PERFORMANCE_DATA: Provides information related to system performance. Notably, data associated with this key isn't stored within the Registry itself but is rather referenced by Registry functions.

HKEY_USERS Provides information related to the default settings assigned to new users.

To better organize keys and subkeys, the Registry employs the concept of hives. A hive is a set of keys and their values. Each hive has specific files associated with it that get loaded into memory upon a trigger, for example, when the system is booted up or when a user authenticates.

Microsoft provides the following table, which lists the standard hives and their supporting files:
Registry hive 	Supporting files
HKEY_CURRENT_CONFIG 	System, System.alt, System.log, System.sav
HKEY_CURRENT_USER 	Ntuser.dat, Ntuser.dat.log
HKEY_LOCAL_MACHINE\SAM 	Sam, Sam.log, Sam.sav
HKEY_LOCAL_MACHINE\Security 	Security, Security.log, Security.sav
HKEY_LOCAL_MACHINE\Software 	Software, Software.log, Software.sav
HKEY_LOCAL_MACHINE\System 	System, System.alt, System.log, System.sav
HKEY_USERS\.DEFAULT 	Default, Default.log, Default.sav

Table 1 - Default Hives and supporting files

- runas /user:Offsec "cmd.exe /C reg add \"HKLM\Software\Student\" /v Flag /t REG_SZ /d \"Now we're cooking with fire!\" /f /reg:64"
- reg add "HKLM\Software\Student" /v Flag /t REG_SZ /d "Now we're cooking with fire!" /f /reg:64
- runas /user:administrator "cmd.exe /C reg delete \"HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "malcolmswarehouse" /f"

- schtasks /query /v /fo LIST
- dir /R
- more < file.txt:whatever


#### Networking
##### TCPDUMP Count
- sudo tcpdump -nn -q -r arp_and_icmp.pcap 2>/dev/null | wc -l 
###### Find all files that are ARP 
- sudo tcpdump -nn -q -r arp_and_icmp.pcap 'arp' 2>/dev/null | wc -l
##### Not ICMP 
- sudo tcpdump -nn -q -r arp_and_icmp.pcap 'not icmp' 2>/dev/null | wc -l 



Administrator:BeefyForehandAttack686

#### Make a variable 
set LOOKHERETOEXECUTE=\\users\\blue\\executeme.exe

#### Shares:
net share mySharedData="C:\Windows\System32" /grant:Everyone,READ

