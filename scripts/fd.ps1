param(
    [string]$folderPath
)

if (Test-Path $folderPath) {
    # Delete all files in the directory quickly, output is sent to null to speed up the process
    del /f/s/q "$folderPath\*" > $null

    # Remove the directory structure
    rmdir /s/q $folderPath
    Write-Host "The folder and all its contents have been deleted."
} else {
    Write-Host "The folder path provided does not exist."
}