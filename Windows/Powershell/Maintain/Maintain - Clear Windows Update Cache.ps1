# Maintain - Clear Windows Update Cache
# Stops Windows Update service and clears the SoftwareDistribution download cache.
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Stop-Service -Name bits -Force -ErrorAction SilentlyContinue
$path = "$env:SystemRoot\SoftwareDistribution\Download"
if (Test-Path $path) {
    Remove-Item "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Output "Cleared: $path"
}
Start-Service -Name wuauserv -ErrorAction SilentlyContinue
Start-Service -Name bits -ErrorAction SilentlyContinue
Write-Output "Windows Update cache cleared."; exit 0
