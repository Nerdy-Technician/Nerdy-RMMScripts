# Check - AutoRun Disabled
# Verifies AutoRun is disabled for all drives via registry; exits 1 if enabled.
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$noDriveTypeAutoRun = (Get-ItemProperty -Path $key -Name NoDriveTypeAutoRun -ErrorAction SilentlyContinue).NoDriveTypeAutoRun
Write-Output "NoDriveTypeAutoRun value: $noDriveTypeAutoRun (0xFF=255 disables all)"
if ($noDriveTypeAutoRun -eq 255 -or $noDriveTypeAutoRun -eq 0xFF) {
    Write-Output "OK: AutoRun is disabled for all drive types."; exit 0
}
Write-Output "WARNING: AutoRun may not be fully disabled. Recommend setting NoDriveTypeAutoRun=0xFF."; exit 1
