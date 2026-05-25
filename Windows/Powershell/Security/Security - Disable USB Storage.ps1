# Security - Disable USB Storage
# Disables USB mass storage by setting USBSTOR service start type to 4 (disabled).
$key = "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR"
Set-ItemProperty -Path $key -Name Start -Value 4 -Type DWORD
$val = (Get-ItemProperty -Path $key -Name Start).Start
if ($val -eq 4) {
    Write-Output "OK: USB mass storage disabled (Start=4)."; exit 0
}
Write-Output "ERROR: Failed to disable USB mass storage."; exit 1
