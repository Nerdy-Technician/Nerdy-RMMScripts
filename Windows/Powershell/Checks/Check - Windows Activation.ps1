# Check - Windows Activation
# Reports Windows license activation status. Exits 1 if not activated.
$lic = Get-CimInstance SoftwareLicensingProduct -Filter "PartialProductKey IS NOT NULL AND Name LIKE 'Windows%'" | Select-Object -First 1
$status = switch ($lic.LicenseStatus) {
  1 { "Licensed" }; 2 { "OOBGrace" }; 3 { "OOTGrace" }; 4 { "NonGenuineGrace" }; 5 { "Notification" }; 6 { "ExtendedGrace" }; default { "Unlicensed" }
}
if ($lic.LicenseStatus -ne 1) { Write-Output "ALERT: Windows activation status: $status"; exit 1 }
Write-Output "Windows activated | Status: $status | Product: $($lic.Name)"; exit 0
