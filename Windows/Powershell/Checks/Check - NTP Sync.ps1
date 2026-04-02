# Check - NTP Sync
# Verifies Windows Time service sync status. Exits 1 if not synced to an external source.
$w32 = w32tm /query /status 2>&1
if ($LASTEXITCODE -ne 0) { Write-Output "ALERT: Windows Time service not responding"; exit 1 }
$source = ($w32 | Select-String "Source:").ToString().Trim()
if ($source -match "Local CMOS Clock|Free-running") {
  Write-Output "ALERT: Clock not synchronized to external NTP source ($source)"
  Write-Output ($w32 -join "`n"); exit 1
}
$w32 | Select-String "Source:|Stratum:|Phase Offset:|Last Successful Sync Time:" | ForEach-Object { $_.ToString().Trim() }
exit 0
