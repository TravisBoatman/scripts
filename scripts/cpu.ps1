param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("shutdown", "restart")]
    [string]$Action
)

Write-Host "The computer will $Action in 30 seconds..."
Start-Sleep -Seconds 30

switch ($Action) {
    "Shutdown" {
        Write-Host "Shutting down the computer..."
        Stop-Computer -Force
    }
    "Restart" {
        Write-Host "Restarting the computer..."
        Restart-Computer -Force
    }
    default {
        Write-Host "Invalid option selected. Please run the script again and choose a valid option."
    }
}
