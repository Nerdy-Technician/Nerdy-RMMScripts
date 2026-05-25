# Collect - Hotfixes
# Lists all installed Windows hotfixes/patches sorted by install date.
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object HotFixID, Description, InstalledOn, InstalledBy | Format-Table -AutoSize
