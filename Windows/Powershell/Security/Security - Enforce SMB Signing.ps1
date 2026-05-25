# Security - Enforce SMB Signing
# Enables mandatory SMB signing on both server and client to prevent relay attacks.
Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Write-Output "SMB signing enforced on server and client."; exit 0
