function Remove-EnvVariable {
    param (
        [string]$name,
        [string]$scope = "Machine"
    )
    if ([System.Environment]::GetEnvironmentVariable($name, $scope)) {
        [System.Environment]::SetEnvironmentVariable($name, $null, $scope)
        Write-Host "Removed environment variable: $name for $scope scope."
    } else {
        Write-Host "Environment variable $name does not exist in $scope scope."
    }
}

function Remove-FromPath {
    param (
        [string]$entryToRemove,
        [string]$scope = "Machine"
    )
    $path = [System.Environment]::GetEnvironmentVariable("PATH", $scope)
    $pathEntries = $path -split ";"
    $newPath = $pathEntries | Where-Object { $_ -notlike $entryToRemove } | ForEach-Object { $_.Trim() } -join ";"
    
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, $scope)
    Write-Host "Removed $entryToRemove from PATH for $scope scope."
}

$setupTerminal = Read-Host "Uninstall will remove modules, environment vars, and clear PS Profile. Do you want to continue? (yes/no)"
if ($setupTerminal -eq "yes") {
    Remove-FromPath -entryToRemove $env:TB_SCRIPTS -scope "Machine"
    Remove-FromPath -entryToRemove $env:TB_ADDITIONAL_SCRIPTS -scope "Machine"

    Remove-EnvVariable -name "TB_PATHS" -scope "Machine"
    Remove-EnvVariable -name "TB_CONFIGS" -scope "Machine"
    Remove-EnvVariable -name "TB_SCRIPTS" -scope "Machine"
    Remove-EnvVariable -name "TB_ADDITIONAL_SCRIPTS" -scope "Machine"

    $filePath = "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    Set-Content -Path $filePath -Value ""

    Remove-Module Terminal-Icons
    Remove-Module PSReadLine
    Remove-Module gsudoModule
    Remove-Module PSScriptTools

    Remove-Item C:\Users\travis.boatman\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\WT Quake
}

Write-Host "Uninstall complete. Restart terminal to apply changes."