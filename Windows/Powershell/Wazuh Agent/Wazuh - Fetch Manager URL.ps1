# Path to the ossec.conf file
$configFile = "C:\Program Files (x86)\ossec-agent\ossec.conf"

# Check if the file exists
if (-Not (Test-Path $configFile)) {
    Write-Host "File not found: $configFile"
    exit 1
}

# Read the file content
$fileContent = Get-Content $configFile -Raw

# Extract value between <address> and </address>
$addressValue = [regex]::Match(
    $fileContent,
    "<address>(.*?)</address>",
    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
).Groups[1].Value

# Output result
if ($addressValue) {
    Write-Host $addressValue
} else {
    Write-Host "No address found in the file."
    exit 1
}
