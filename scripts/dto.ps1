param (
    [string]$TeamEmail,
    [DateTime]$From,
    [DateTime]$To,
    [string]$EventName,
    [switch]$AllDay
)

$Outlook = New-Object -ComObject Outlook.Application

function Create-Event {
    param (
        [DateTime]$Start,
        [DateTime]$End,
        [string]$Subject,
        [string]$BusyStatus,
        [int]$Sensitivity,
        [string]$OptionalAttendee = $null,
        [switch]$AllDay
    )

    $Appointment = $Outlook.CreateItem(1) # 1 = Appointment
    $Appointment.Subject = $Subject
    $Appointment.Start = $Start
    $Appointment.End = $End
    $Appointment.BusyStatus = $BusyStatus
    $Appointment.Sensitivity = $Sensitivity
    $Appointment.ResponseRequested = $false
    $Appointment.ReminderSet = $false

    if ($AllDay) {
        $Appointment.AllDayEvent = $true
    }

    if ($OptionalAttendee) {
        $Appointment.Recipients.Add($OptionalAttendee)
    }

    $Appointment.Save()
}

# Create the first event (Private, Out of Office)
Create-Event -Start $From -End $To -Subject $EventName -BusyStatus 3 -Sensitivity 2 -AllDay:$AllDay # 3 = OutOfOffice, 2 = Private

# Create the second event (Public, Free, with attendee)
Create-Event -Start $From -End $To -Subject $EventName -BusyStatus 0 -Sensitivity 0 -OptionalAttendee $TeamEmail -AllDay:$AllDay # 0 = Free, 0 = Normal (Public)
