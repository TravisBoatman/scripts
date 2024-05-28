$content = "& ""$env:TB_SCRIPTS\profile.ps1"""
$filePath = "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Set-Content -Path $filePath -Value $content