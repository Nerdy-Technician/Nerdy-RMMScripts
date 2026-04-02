# Monitor - CPU Usage
# Reports CPU load percentage. Exits 1 if >85%, 2 if >65%.
$cpu = [math]::Round((Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average, 1)
if ($cpu -gt 85) { Write-Output "ALERT: CPU usage >85% ($cpu%)"; exit 1 }
if ($cpu -gt 65) { Write-Output "WARNING: CPU usage >65% ($cpu%)"; exit 2 }
Write-Output "CPU usage normal: $cpu%"; exit 0
