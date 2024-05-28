param(
    [string]$ServerName,
    [string]$User,
    [string]$Password,
    [string]$ToggleName,
    [string]$OnOff
)

function Convert-OnOffToBit {
    param(
        [string]$OnOff
    )
    
    if ($OnOff -eq "on") {
        return 1
    } elseif ($OnOff -eq "off") {
        return 0
    } else {
        throw "Invalid On/Off parameter value. Please use 'on' or 'off'."
    }
}

$OnOffBit = Convert-OnOffToBit -OnOff $OnOff

$connectionString = "Server=$ServerName;Database=EDDS;User ID=$User;Password=$Password"
$connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
$command = $connection.CreateCommand()
$command.CommandText = "EDDS.eddsdbo.pr_SetToggle"
$command.CommandType = [System.Data.CommandType]::StoredProcedure

$toggleParam = $command.Parameters.Add("@Name", [System.Data.SqlDbType]::VarChar, 255)
$toggleParam.Value = $ToggleName

$onOffParam = $command.Parameters.Add("@IsEnabled", [System.Data.SqlDbType]::Bit)
$onOffParam.Value = $OnOffBit

try {
    $connection.Open()
    $rowsAffected = $command.ExecuteNonQuery()
    Write-Host "Toggle set successfully."
} catch {
    Write-Error "An error occurred: $_"
} finally {
    $connection.Close()
}