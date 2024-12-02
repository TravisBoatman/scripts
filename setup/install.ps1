if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Please run this script as an Administrator!"
    exit
}

Write-Host "Please ensure you are running this script under PowerShell 7 and a Hack Nerd Font is installed before continuing."
$choice = Read-Host "To continue press 'y' or 'n' to cancel."

if ($choice -ieq 'y') {
    Write-Host "Continuing with the script..." -ForegroundColor Yellow
} elseif ($choice -ieq 'n') {
    Write-Host "Script canceled by user." -ForegroundColor Yellow
    exit
} else {
    Write-Host "Invalid input. Please run the script again and choose 'y' or 'n'." -ForegroundColor Red
    exit
}

Install-Module Terminal-Icons -Force
Install-Module PSReadLine -Force

Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
Set-ExecutionPolicy RemoteSigned -scope Process; [Net.ServicePointManager]::SecurityProtocol = 'Tls12'; Invoke-WebRequest -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | Invoke-Expression

$CurrentScriptPath = $PSScriptRoot
$ParentDirectory = (Get-Item -Path $CurrentScriptPath).Parent.FullName
[Environment]::SetEnvironmentVariable("TB_SCRIPTS", "$ParentDirectory", "Machine")

Write-Host "Install completed. Close any open consoles then run ps-profile.ps1 to complete setup.`n" -ForegroundColor Yellow