# Collect - Uptime
# Reports system uptime in days, hours, and minutes.
$os = Get-CimInstance Win32_OperatingSystem
$uptime = (Get-Date) - $os.LastBootUpTime
Write-Output "Last boot: $($os.LastBootUpTime)"
Write-Output "Uptime: $($uptime.Days)d $($uptime.Hours)h $($uptime.Minutes)m"
