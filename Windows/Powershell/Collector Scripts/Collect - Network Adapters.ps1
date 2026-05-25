# Collect - Network Adapters
# Lists all network adapters with IP addresses, MAC addresses, and link speed.
Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | ForEach-Object {
    $ip = (Get-NetIPAddress -InterfaceIndex $_.InterfaceIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue).IPAddress
    [PSCustomObject]@{
        Name      = $_.Name
        MAC       = $_.MacAddress
        IP        = $ip -join ', '
        SpeedMbps = [math]::Round($_.LinkSpeed / 1MB, 0)
        Status    = $_.Status
    }
} | Format-Table -AutoSize
