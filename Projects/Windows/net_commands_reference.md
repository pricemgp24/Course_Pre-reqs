# Net Commands On Operating Systems

**Date:** 01/15/2025  
**Contributors:** 3  
**Author:** Nirmal Sharma, Microsoft MVP  
**Original KB number:** 556003

---

## Summary

This article provides information about Net Commands on Windows Operating Systems. These commands can be used to perform operations on groups, users, account policies, shares, and more.

---

## Available NET Commands

- ACCOUNTS  
- COMPUTER  
- CONFIG  
- CONTINUE  
- FILE  
- GROUP  
- HELP  
- HELPMSG  
- LOCALGROUP  
- NAME  
- PAUSE  
- PRINT  
- SEND  
- SESSION  
- SHARE  
- START  
- STATISTICS  
- STOP  
- TIME  
- USE  
- USER  
- VIEW  

---

## Net Accounts

The `Net Accounts` command is used to configure policy settings such as account and password policies on a **local computer only** (not on domain controllers).

### Example Output

```
Force user logoff how long after time expires?: Never  
Minimum password age (days): 1  
Maximum password age (days): 90  
Minimum password length: 8  
Length of password history maintained: 5  
Lockout threshold: 4  
Lockout duration (minutes): 4  
Lockout observation window (minutes): 4  
Computer role: WORKSTATION
```

These settings vary depending on whether the computer is part of a domain. If joined to a domain, domain GPO settings take precedence.

---

## Net Accounts Syntax Options

```
NET ACCOUNTS  
[/FORCELOGOFF:{minutes | NO}]  
[/MINPWLEN:length]  
[/MAXPWAGE:{days | UNLIMITED}]  
[/MINPWAGE:days]  
[/UNIQUEPW:number]  
[/DOMAIN]
```

### Option Descriptions

- **/FORCELOGOFF:{minutes | NO}** — Set logoff delay when account/logon hours expire.
- **/MINPWLEN:length** — Minimum password length (0–14); default is 6.
- **/MAXPWAGE:{days | UNLIMITED}** — Maximum password age (1–999); default is 90 days.
- **/MINPWAGE:days** — Minimum password age (0–999); default is 0.
- **/UNIQUEPW:number** — Enforces unique passwords for up to 24 changes.
- **/DOMAIN** — Applies the operation on a domain controller if used; otherwise, applies locally.

---

## Disclaimer

Microsoft and/or its suppliers make no warranties regarding the content herein. The information is provided "as is" without warranty of any kind. Microsoft disclaims all warranties including implied warranties of merchantability and fitness for a particular purpose. They are not liable for damages arising from use of this content.

