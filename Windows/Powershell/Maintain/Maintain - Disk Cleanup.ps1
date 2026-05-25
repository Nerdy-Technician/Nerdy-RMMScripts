# Maintain - Disk Cleanup
# Runs Windows Disk Cleanup silently using CleanMgr with sageset profile 99.
$sageset = 99
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
Get-ChildItem $regPath | ForEach-Object {
    Set-ItemProperty -Path $_.PsPath -Name "StateFlags$sageset" -Value 2 -Type DWORD -ErrorAction SilentlyContinue
}
Write-Output "Running Disk Cleanup (sageset $sageset)..."
Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:$sageset" -Wait
Write-Output "Disk Cleanup complete."; exit 0
