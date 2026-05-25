# Security - SMB Signing Status
# Checks if SMB signing is required on the server and client; exits 1 if not required.
$serverSigning = (Get-SmbServerConfiguration).RequireSecuritySignature
$clientSigning = (Get-SmbClientConfiguration).RequireSecuritySignature
Write-Output "SMB Server signing required: $serverSigning"
Write-Output "SMB Client signing required: $clientSigning"
if (-not $serverSigning -or -not $clientSigning) {
    Write-Output "ALERT: SMB signing not enforced. Vulnerable to relay attacks."; exit 1
}
Write-Output "OK: SMB signing is required on server and client."; exit 0
