# Audit - Local Admins
# Lists members of the local Administrators group including their source (local/domain/Azure AD).
Get-LocalGroupMember -Group 'Administrators' |
  Select-Object Name, ObjectClass, PrincipalSource |
  Format-Table -AutoSize
