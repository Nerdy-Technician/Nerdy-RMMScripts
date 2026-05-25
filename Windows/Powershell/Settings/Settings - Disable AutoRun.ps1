# Settings - Disable AutoRun
# Disables AutoRun for all drive types via registry (NoDriveTypeAutoRun=0xFF).
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $key)) { New-Item -Path $key -Force | Out-Null }
Set-ItemProperty -Path $key -Name NoDriveTypeAutoRun -Value 0xFF -Type DWord
Write-Output "AutoRun disabled for all drive types."; exit 0
