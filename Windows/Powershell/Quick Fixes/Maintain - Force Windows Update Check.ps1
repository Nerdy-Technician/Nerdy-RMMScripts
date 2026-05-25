# Maintain - Force Windows Update Check
# Forces Windows Update to check for and queue available updates immediately.
$updateSession = New-Object -ComObject Microsoft.Update.Session
$searcher = $updateSession.CreateUpdateSearcher()
Write-Output "Searching for updates..."
$result = $searcher.Search("IsInstalled=0 and Type='Software'")
Write-Output "Found $($result.Updates.Count) update(s)."
if ($result.Updates.Count -gt 0) {
    $downloader = $updateSession.CreateUpdateDownloader()
    $downloader.Updates = $result.Updates
    Write-Output "Downloading updates..."
    $downloader.Download() | Out-Null
    Write-Output "Download complete. Updates queued for install."; exit 0
}
Write-Output "No updates to download."; exit 0
