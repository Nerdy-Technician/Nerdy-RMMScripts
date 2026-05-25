# Audit - Failed Logins
# Reports failed login events (4625) from the last 24 hours; exits 1 if count >20.
$THRESHOLD = 20
$since = (Get-Date).AddHours(-24)
$events = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625; StartTime=$since} -ErrorAction SilentlyContinue
$count = if ($events) { $events.Count } else { 0 }
Write-Output "Failed login attempts in last 24h: $count"
if ($events) { $events | Select-Object TimeCreated, Message | Select-Object -First 20 | Format-List }
if ($count -gt $THRESHOLD) { Write-Output "ALERT: Failed logins ($count) exceed threshold ($THRESHOLD)."; exit 1 }
Write-Output "OK: Failed login count within acceptable range."; exit 0
