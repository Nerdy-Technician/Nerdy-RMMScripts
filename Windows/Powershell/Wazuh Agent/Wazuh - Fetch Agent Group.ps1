# Path to the ossec.conf file
$configFile = "C:\Program Files (x86)\ossec-agent\ossec.conf"

# Check if the file exists
if (-Not (Test-Path $configFile)) {
    Write-Host "File not found: $configFile"
    exit
}

# Read the file content
$fileContent = Get-Content $configFile -Raw

# Extract the content between <groups> and </groups> using a regular expression
$groupsContent = [regex]::Match($fileContent, "<groups>(.*?)</groups>").Groups[1].Value

# Check if content was found
if (-Not $groupsContent) {
    Write-Host "No groups found in the file."
} else {
    Write-Host "$groupsContent"
}