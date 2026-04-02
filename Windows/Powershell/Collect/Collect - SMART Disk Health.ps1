# Collect - SMART Disk Health
# Reports SMART failure prediction status per physical disk via WMI. Exits 1 if failure predicted.
$disks = Get-WmiObject -Namespace root\wmi -Class MSStorageDriver_FailurePredictStatus -ErrorAction SilentlyContinue
if (-not $disks) { Write-Output "SMART data unavailable (driver not supported or no WMI access)"; exit 0 }
$failed = $disks | Where-Object { $_.PredictFailure -eq $true }
$disks | Select-Object @{N='Disk';E={($_.InstanceName -split '_')[0]}},
                        @{N='SMART Status';E={if($_.PredictFailure){'FAILING'}else{'OK'}}} |
  Format-Table -AutoSize
if ($failed) { Write-Output "ALERT: SMART failure predicted on $($failed.Count) disk(s)"; exit 1 }
exit 0
