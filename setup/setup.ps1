function Set-EnvVariable([string]$name, [string]$default) {
    $path = Read-Host "Enter path for $name or press Enter to use default ($default)"
    if (-not $path) {
        $path = $default
    }
    [System.Environment]::SetEnvironmentVariable($name, $path, [System.EnvironmentVariableTarget]::Machine)
}

Install-Module Terminal-Icons
Install-Module PSReadLine
Install-Module gsudoModule
Install-Module PSScriptTools
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

$currentDirectory = Get-Location
Set-EnvVariable -name "TB_SCRIPTS" -default "$currentDirectory\scripts"
Set-EnvVariable -name "TB_CONFIGS" -default "$currentDirectory\configs"
Set-EnvVariable -name "TB_PATHS" -default "$currentDirectory\paths"

$setupTerminal = Read-Host "Do you want to use custom terminal settings (Quake Mode, Hack Font, Nord Theme? (yes/no)"
if ($setupTerminal -eq "yes") {
    
    # Set Windows Terminal settings
    $content = Get-Content -Path "..\configs\term-settings.json"
    $filePath = "$home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    Set-Content -Path $filePath -Value $content

    # Create shortcut for Windows Terminal Quake mode
    $shortcutPath = "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\WT Quake.lnk"
    $targetPath = "$home\AppData\Local\Microsoft\WindowsApps\wt.exe"
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = $targetPath
    $Shortcut.Arguments = "-w _quake"
    $Shortcut.Save()

    Write-Host "Terminal settings and Quake mode setup complete."

    # Add HACK font
    $url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip"
    $zipFile = "C:\Temp\Hack.zip"
    $extractPath = "C:\Temp\Hack"

    if (!(Test-Path "C:\Temp")) {
        New-Item -ItemType Directory -Force -Path "C:\Temp"
    }

    Invoke-WebRequest -Uri $url -OutFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $extractPath

    Get-ChildItem -Path "$extractPath\*.ttf" -Recurse | ForEach-Object {
        $font = $_.FullName
        Add-Type -AssemblyName System.Drawing
        $fontObj = New-Object System.Drawing.Text.PrivateFontCollection
        $fontObj.AddFontFile($font)
        $fontfamily = $fontObj.Families[0].Name
        $filePath = $env:windir + "\Fonts\" + $fontfamily + ".ttf"
        Copy-Item $font -Destination $filePath
        $fonts = New-Object -ComObject Shell.Application
        $folder = $fonts.NameSpace(0x14)
        $folder.ParseName($filePath).InvokeVerb("Install")
    }

    Remove-Item -Path $extractPath -Recurse -Force
    Remove-Item -Path $zipFile -Force
    Write-Host "Fonts installed and cleanup complete."
}

Write-Host "Setup complete. Restart terminal to apply changes. Then run ps-profile.ps1 to setup PowerShell profile."