# Settings - Set DNS Servers
# Sets DNS servers on all active adapters. Edit $primary and $secondary to suit.
$primary   = "1.1.1.1"
$secondary = "1.0.0.1"
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
foreach ($a in $adapters) {
    Set-DnsClientServerAddress -InterfaceIndex $a.InterfaceIndex -ServerAddresses ($primary, $secondary)
    Write-Output "Set DNS on $($a.Name): $primary, $secondary"
}
exit 0
