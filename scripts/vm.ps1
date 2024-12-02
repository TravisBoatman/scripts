param (
    [Parameter(Position=0, Mandatory=$true)]
    [ValidateSet('Start', 'Stop', 'Revert', 'Restart', 'Status', 'Save')]
    [string]$Action,

    [Parameter(Position=1, Mandatory=$false)]
    [string]$vmName
)

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Please run this script as an Administrator!"
    exit
}

if (Get-Module -ListAvailable -Name Hyper-V) {
    Import-Module Hyper-V
} else {
    Write-Error "Hyper-V module is not available."
    exit
}

if (-not $vmName) {
    $vmName = Get-VM | Sort-Object CreationTime -Descending | Select-Object -First 1 -ExpandProperty Name
    if (-not $vmName) {
        Write-Error "No VMs found on this system."
        exit
    }
    Write-Output "No VM name was provided. Using the latest created VM: $vmName"
}

switch ($Action) {
    'start' {
        $vmState = Get-VM -Name $vmName | Select-Object -ExpandProperty State
        if ($vmState -ne 'Running') {
            Start-VM -Name $vmName
            Write-Output "VM '$vmName' is starting."
        } else {
            Write-Output "VM '$vmName' is already running."
        }
    }
    'stop' {
        $vmState = Get-VM -Name $vmName | Select-Object -ExpandProperty State
        if ($vmState -ne 'Off') {
            Stop-VM -Name $vmName -Force
            Write-Output "VM '$vmName' is stopping."
        } else {
            Write-Output "VM '$vmName' is already stopped."
        }
    }
    'save' {
        $vmState = Get-VM -Name $vmName | Select-Object -ExpandProperty State
        if ($vmState -ne 'Off') {
            Save-VM -Name $vmName
            Write-Output "VM '$vmName' is saving."
        } else {
            Write-Output "VM '$vmName' is already stopped."
        }
    }
    'revert' {
        $checkpoint = Get-VMSnapshot -VMName $vmName | Sort-Object -Property CreationTime -Descending | Select-Object -First 1
        if ($checkpoint) {
            Restore-VMSnapshot -VMName $vmName -Name $checkpoint.Name
            Write-Output "VM '$vmName' is reverting to the last checkpoint."
        } else {
            Write-Error "No checkpoints found for VM '$vmName'."
        }
    }
    'restart' {
        Restart-VM -Name $vmName -Force
        Write-Output "VM '$vmName' is restarting."
    }
    'status' {
        $vmState = Get-VM -Name $vmName | Select-Object -ExpandProperty State
        Write-Output "VM '$vmName' is currently $vmState."
    }
}