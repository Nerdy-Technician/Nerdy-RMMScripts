# Check - Antivirus Status
# Checks registered antivirus products via WMI; exits 1 if none found or product is outdated.
$av = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct -ErrorAction SilentlyContinue
if (-not $av) { Write-Output "ALERT: No antivirus product registered in Security Center."; exit 1 }
foreach ($product in $av) {
    $hex = '{0:X}' -f $product.productState
    $enabled = $hex.Substring(1,1) -eq '1'
    $updated = $hex.Substring(3,1) -eq '0'
    Write-Output "AV: $($product.displayName)"
    Write-Output "  Enabled: $enabled | Up-to-date: $updated"
    if (-not $enabled) { Write-Output "ALERT: $($product.displayName) is not enabled."; exit 1 }
    if (-not $updated) { Write-Output "WARNING: $($product.displayName) definitions may be outdated."; exit 2 }
}
Write-Output "OK: Antivirus is active and up-to-date."; exit 0
