param (
    [Parameter(Mandatory=$false)]
    [string]$location = 'help'
)

$locations = @{
    "projects" = "/Projects"
    "home"     = "$home\Documents"
    "vs"       = "$home\source\repos"
    "temp"     = "$home\Documents\Temp"
    "desktop"  = "$home\Desktop"
}

function Show-Locations {
    Write-Host "Available locations:"
    $locations.Keys | Sort-Object | ForEach-Object { Write-Host "`t$_" }
}

if ($location -eq "help") {
    Show-Locations
    exit
}

if ($locations.ContainsKey($location)) {
    cd $locations[$location]
} else {
    Write-Host "Unknown location: $location"
    Show-Locations
}
