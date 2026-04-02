# Monitor - Windows Defender Status
# Checks real-time protection state and definition age. Exits 1 if disabled or definitions >3 days old.
$s = Get-MpComputerStatus
$defAge = [math]::Round(((Get-Date) - $s.AntivirusSignatureLastUpdated).TotalDays, 1)
if (-not $s.RealTimeProtectionEnabled) { Write-Output "ALERT: Real-time protection is DISABLED"; exit 1 }
if ($defAge -gt 3) { Write-Output "ALERT: Definitions are $defAge day(s) old"; exit 1 }
Write-Output "Defender OK | RTP: Enabled | Definitions: $defAge day(s) old | Version: $($s.AntivirusSignatureVersion)"
exit 0
