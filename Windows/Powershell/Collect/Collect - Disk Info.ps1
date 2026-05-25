# Collect - Disk Info
# Reports physical disk details including model, size, media type, and health status.
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, Size, HealthStatus, OperationalStatus |
    ForEach-Object {
        $_.Size = "$([math]::Round($_.Size / 1GB, 1)) GB"
        $_
    } | Format-Table -AutoSize
