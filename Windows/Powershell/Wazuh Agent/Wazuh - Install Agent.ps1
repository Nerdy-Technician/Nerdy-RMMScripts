param(
    [string]$WazuhGroup   = $env:WazuhGroup,
    [string]$WazuhManager = $env:WazuhManager
)

# ---------------------------
# Validate required variables
# ---------------------------
if ([string]::IsNullOrWhiteSpace($WazuhManager)) {
    Write-Error "WazuhManager is not set. Configure it in Tactical RMM Site Settings."
    exit 1
}

if ([string]::IsNullOrWhiteSpace($WazuhGroup)) {
    Write-Host "WazuhGroup not set. Defaulting to 'default'."
    $WazuhGroup = "default"
}

Write-Host "Wazuh Manager: $WazuhManager"
Write-Host "Wazuh Group:   $WazuhGroup"

# ---------------------------
# Check for existing service
# ---------------------------
$wazuhService = Get-Service -Name "WazuhSvc" -ErrorAction SilentlyContinue

if ($wazuhService) {
    if ($wazuhService.Status -eq "Running") {
        Write-Host "Wazuh agent already installed and running."
        exit 0
    }

    Write-Host "Wazuh service exists but is not running. Attempting to start..."
    Start-Service -Name "WazuhSvc"

    Write-Host "Wazuh service started successfully."
    exit 0
}

# ---------------------------
# Install Wazuh Agent
# ---------------------------
$InstallerUrl  = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.14.1-1.msi"
$InstallerPath = Join-Path $env:TEMP "wazuh-agent.msi"


Write-Host "Downloading Wazuh agent..."
Invoke-WebRequest -Uri $InstallerUrl -OutFile $InstallerPath -UseBasicParsing

Write-Host "Installing Wazuh agent..."
$process = Start-Process "msiexec.exe" `
    -ArgumentList "/i `"$InstallerPath`" /qn WAZUH_MANAGER=$WazuhManager WAZUH_AGENT_GROUP=$WazuhGroup" `
    -Wait `
    -PassThru `
    -NoNewWindow

if ($process.ExitCode -ne 0) {
    Write-Error "Wazuh MSI installation failed with exit code $($process.ExitCode)"
    exit 1
}

Write-Host "Starting Wazuh service..."
Start-Service -Name "WazuhSvc"

Write-Host "Wazuh agent installation completed successfully."
exit 0