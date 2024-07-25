param (
    [Parameter(Mandatory=$false)]
    [string[]]$names = @('help')
)

function Show-Options {
    Write-Host "Available options:"
    $actions.Keys | Sort-Object | ForEach-Object { Write-Host "`t$_" }
}

function Expand-PathVariables($path) {
    return $ExecutionContext.InvokeCommand.ExpandString($path)
}

function Is-Url($string) {
    return $string -match "^https?://"
}

function Is-Path($string) {
    return Test-Path $string
}

try {
    $jsonPath = [System.Environment]::ExpandEnvironmentVariables("$env:TB_PATHS\actions.json")
    $actions = Get-Content -Path $jsonPath -ErrorAction Stop | ConvertFrom-Json
} catch {
    Write-Host "Error loading actions data from JSON file. Please check the file path and format."
    exit
}

if ($names -contains "help") {
    Show-Options
    exit
}

foreach ($name in $names) {
    if ($actions.PSObject.Properties.Name -contains $name) {
        $resolvedPath = Expand-PathVariables $actions.$name
        
        if (Is-Url $resolvedPath) {
            Start-Process -FilePath $resolvedPath
        } elseif (Is-Path $resolvedPath) {
            Start-Process -FilePath $resolvedPath
        } else {
            $parts = $resolvedPath -split ' ', 2
            $exe = $parts[0]
            $args1 = if ($parts.Count -gt 1) { $parts[1] } else { $null }
            Start-Process -FilePath $exe -ArgumentList $args1
        }
    } else {
        Write-Host "Unknown option: $name"
        Show-Options
    }
}
