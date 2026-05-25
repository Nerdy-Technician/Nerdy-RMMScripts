# Security - Guest Account Status
# Checks if the built-in Guest account is enabled; exits 1 if enabled.
$guest = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue
if (-not $guest) { Write-Output "INFO: Guest account not found."; exit 0 }
if ($guest.Enabled) {
    Write-Output "ALERT: Guest account is ENABLED. This is a security risk."; exit 1
}
Write-Output "OK: Guest account is disabled."; exit 0
