# Monitor - RAM Usage
# Reports physical memory usage percentage. Exits 1 if >85%, 2 if >65%.
$os = Get-CimInstance Win32_OperatingSystem
$used = [math]::Round(($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize * 100, 1)
if ($used -gt 85) { Write-Output "ALERT: RAM usage >85% ($used%)"; exit 1 }
if ($used -gt 65) { Write-Output "WARNING: RAM usage >65% ($used%)"; exit 2 }
Write-Output "RAM usage normal: $used%"; exit 0
