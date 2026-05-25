# Monitor - Page File Usage
# Reports page file usage percentage; exits 1 if >80%, 2 if >60%.
$pf = Get-CimInstance Win32_PageFileUsage
foreach ($p in $pf) {
    $pct = [math]::Round(($p.CurrentUsage / $p.AllocatedBaseSize) * 100, 1)
    Write-Output "Page file: $($p.Name) - $($p.CurrentUsage)MB / $($p.AllocatedBaseSize)MB ($pct%)"
    if ($pct -gt 80) { Write-Output "ALERT: Page file usage exceeds 80%."; exit 1 }
    if ($pct -gt 60) { Write-Output "WARNING: Page file usage exceeds 60%."; exit 2 }
}
Write-Output "OK: Page file usage within limits."; exit 0
