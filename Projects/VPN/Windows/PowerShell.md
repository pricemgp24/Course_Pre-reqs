#### Checking For Hashes:
```
$target = '6CECC33A62E935F5E8665B9597479A36'

# Real System32 even from 32-bit PS:
Get-ChildItem "$env:windir\sysnative" -File -Force -ErrorAction SilentlyContinue |
  ForEach-Object {
    $h = Get-FileHash -Path $_.FullName -Algorithm MD5
    if ($h.Hash -ieq $target) { $_.Name; break }
  }
```