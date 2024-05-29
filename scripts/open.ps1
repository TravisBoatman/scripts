param (
    [Parameter(Mandatory=$false)]
    [string]$name = 'help'
)

function Show-Options {
    Write-Host "Available options:"
    $actions.Keys | Sort-Object | ForEach-Object { Write-Host "`t$_" }
}

function Expand-PathVariables($path) {
    return $ExecutionContext.InvokeCommand.ExpandString($path)
}

try {
    $jsonPath = [System.Environment]::ExpandEnvironmentVariables("$env:TB_PATHS\actions.json")
    $actions = Get-Content -Path $jsonPath -ErrorAction Stop | ConvertFrom-Json
} catch {
    Write-Host "Error loading actions data from JSON file. Please check the file path and format."
    exit
}

if ($name -eq "help") {
    Show-Options
    exit
}

if ($actions.PSObject.Properties.Name -contains $name) {
    $resolvedPath = Expand-PathVariables $actions.$name
    Start-Process $resolvedPath
} else {
    Write-Host "Unknown option: $name"
    Show-Options
}
