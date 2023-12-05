# Define the old and new server names and scope name
$OldServerName = "corpad1"
$NewServerName = "condhcp01"
$scopeId = "172.21.19.0"

# Export reservations from the old server
Get-DhcpServerv4Reservation -ComputerName $OldServerName -ScopeID $ScopeId | Export-Csv -Path C:\temp\ExportedReservations$scopeId.csv -NoTypeInformation

# Transfer the CSV file to the new server using your preferred method

# Import reservations on the new server
Import-Csv -Path C:\temp\ExportedReservations$scopeId.csv | ForEach-Object {
    Add-DhcpServerv4Reservation -ComputerName $NewServerName -ScopeID $ScopeId -IPAddress $_.IPAddress -ClientId $_.ClientID -Description $_.Description -Name $_.Name
} 
