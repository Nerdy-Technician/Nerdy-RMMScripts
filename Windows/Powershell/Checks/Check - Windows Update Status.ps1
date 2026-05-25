# Check - Windows Update Status
# Checks for pending Windows updates; exits 1 if critical updates pending, 2 if any pending.
$updateSession = New-Object -ComObject Microsoft.Update.Session
$searcher = $updateSession.CreateUpdateSearcher()
try {
    $result = $searcher.Search("IsInstalled=0 and Type='Software'")
    $total = $result.Updates.Count
    $critical = ($result.Updates | Where-Object { $_.MsrcSeverity -eq 'Critical' }).Count
    Write-Output "Pending updates: $total (Critical: $critical)"
    $result.Updates | Select-Object Title, MsrcSeverity | Format-Table -AutoSize
    if ($critical -gt 0) { Write-Output "ALERT: $critical critical update(s) pending."; exit 1 }
    if ($total -gt 0)    { Write-Output "WARNING: $total update(s) pending."; exit 2 }
    Write-Output "OK: No pending Windows updates."; exit 0
} catch {
    Write-Output "ERROR: Could not query Windows Update: $_"; exit 1
}
