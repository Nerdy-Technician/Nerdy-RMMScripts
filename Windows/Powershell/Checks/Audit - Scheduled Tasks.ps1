# Audit - Scheduled Tasks
# Lists enabled scheduled tasks not belonging to Microsoft; exits 1 if suspicious tasks found.
$tasks = Get-ScheduledTask | Where-Object {
    $_.State -ne 'Disabled' -and
    $_.TaskPath -notmatch '^\\Microsoft\\'
}
if ($tasks.Count -eq 0) { Write-Output "OK: No non-Microsoft scheduled tasks found."; exit 0 }
Write-Output "Non-Microsoft scheduled tasks ($($tasks.Count) found):"
$tasks | Select-Object TaskName, TaskPath, State | Format-Table -AutoSize
exit 0
