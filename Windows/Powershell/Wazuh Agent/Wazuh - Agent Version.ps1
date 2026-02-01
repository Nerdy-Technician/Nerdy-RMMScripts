# Function to get Wazuh agent version
function Get-WazuhAgentVersion {
    # Path to the Wazuh agent executable
    $agentPath = "C:\Program Files (x86)\ossec-agent\wazuh-agent.exe"
    
    # Check if the agent executable exists
    if (Test-Path $agentPath) {
        # Get the version information of the agent executable
        $versionInfo = Get-Item $agentPath | Select-Object -ExpandProperty VersionInfo
        $version = $versionInfo.FileVersion

        # Output the version
        Write-Output "$version"
    } else {
        Write-Output "Not found."
    }
}

# Call the function to get the version
Get-WazuhAgentVersion