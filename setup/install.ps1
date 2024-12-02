Write-Host "Please ensure PowerShell 7 and a Hack Nerd Font is installed before running this script."
$choice = Read-Host "To continue press 'y' or 'n' to cancel."

if ($choice -ieq 'y') {
    Write-Host "Continuing with the script..."
} elseif ($choice -ieq 'n') {
    Write-Host "Script canceled by user."
    exit
} else {
    Write-Host "Invalid input. Please run the script again and choose 'y' or 'n'."
    exit
}

Install-Module Terminal-Icons -Force
Install-Module PSReadLine -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
Set-ExecutionPolicy RemoteSigned -scope Process; [Net.ServicePointManager]::SecurityProtocol = 'Tls12'; Invoke-WebRequest -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | Invoke-Expression

Set-EnvVariable -name "TB_SCRIPTS" -default "$PSScriptRoot\.."

Write-Host "Install completed. Close any open consoles then run ps-profile.ps1 to complete setup."