# Monitor - Disk Space
# Reports disk usage for all fixed drives; exits 1 if any drive >90%, 2 if >75%.
$drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match '^[A-Z]:\\' }
$alert = $false; $warn = $false
foreach ($d in $drives) {
    $total = $d.Used + $d.Free
    if ($total -eq 0) { continue }
    $pct = [math]::Round(($d.Used / $total) * 100, 1)
    Write-Output "$($d.Root) - Used: $([math]::Round($d.Used/1GB,1))GB / $([math]::Round($total/1GB,1))GB ($pct%)"
    if ($pct -gt 90) { $alert = $true }
    elseif ($pct -gt 75) { $warn = $true }
}
if ($alert) { Write-Output "ALERT: One or more drives exceed 90% usage."; exit 1 }
if ($warn)  { Write-Output "WARNING: One or more drives exceed 75% usage."; exit 2 }
Write-Output "OK: All drives within limits."; exit 0
