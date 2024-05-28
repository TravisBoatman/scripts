param(
    [string]$Scripts,

    [string]$Configs,

    [string]$Paths
)

if (-not $Scripts -or -not $Configs -or -not $Paths) {
    Write-Host "Please provide a value for TB_SCRIPTS, TB_CONFIGS or TB_PATHS environment variables."
    exit
}

[Environment]::SetEnvironmentVariable('TB_SCRIPTS', $Scripts, 'Machine')
[Environment]::SetEnvironmentVariable('TB_CONFIGS', $Configs, 'Machine')
[Environment]::SetEnvironmentVariable('TB_PATHS', $Paths, 'Machine')

Write-Host "The environment variable TB_SCRIPTS has been set to: $Scripts"
Write-Host "The environment variable TB_CONFIGS has been set to: $Configs"
Write-Host "The environment variable TB_PATHS has been set to: $Paths"