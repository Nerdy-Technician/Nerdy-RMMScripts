# Security - USB Storage Disabled
# Checks if USB mass storage is disabled via registry; exits 1 if enabled.
$key = "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR"
$start = (Get-ItemProperty -Path $key -Name Start -ErrorAction SilentlyContinue).Start
if ($start -eq 4) {
    Write-Output "OK: USB mass storage is disabled (Start=4)."; exit 0
}
Write-Output "WARNING: USB mass storage is not disabled (Start=$start). Set to 4 to disable."; exit 1
