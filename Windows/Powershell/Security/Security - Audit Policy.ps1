# Security - Audit Policy
# Enumerates Windows audit policy settings across all categories via auditpol.
auditpol /get /category:* 2>&1
