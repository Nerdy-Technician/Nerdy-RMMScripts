# Monitor - Event Log Error Rate
# Counts Error/Critical events in System and Application logs in the last hour. Exits 1 if above threshold.
$threshold = 50
$since = (Get-Date).AddHours(-1)
$count = (Get-WinEvent -FilterHashtable @{LogName='System','Application'; Level=1,2; StartTime=$since} -ErrorAction SilentlyContinue | Measure-Object).Count
if ($count -gt $threshold) { Write-Output "ALERT: $count error/critical events in last hour (threshold $threshold)"; exit 1 }
Write-Output "Event log errors last hour: $count (threshold $threshold)"; exit 0
