# Monitor - Disk IO Activity
# Samples disk read/write rates and queue length over 3 seconds via performance counters.
$counters = '\PhysicalDisk(_Total)\Disk Reads/sec',
            '\PhysicalDisk(_Total)\Disk Writes/sec',
            '\PhysicalDisk(_Total)\% Disk Time',
            '\PhysicalDisk(_Total)\Current Disk Queue Length'
Get-Counter $counters -SampleInterval 3 -MaxSamples 1 |
  Select-Object -ExpandProperty CounterSamples |
  Select-Object @{N='Counter';E={($_.Path -split '\\')[-1]}}, @{N='Value';E={[math]::Round($_.CookedValue,2)}} |
  Format-Table -AutoSize
