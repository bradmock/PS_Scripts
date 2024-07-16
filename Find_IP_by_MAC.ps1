# Replace with the MAC address you are looking for
$macAddress = "78-8c-77-a1-83-84"

# Replace with your DHCP server name or IP
$dhcpServer = "condhcp01"

# Retrieve all scopes
$scopes = Get-DhcpServerv4Scope -ComputerName $dhcpServer

# Initialize a variable to store the lease
$lease = $null

# Iterate through each scope to find the lease
foreach ($scope in $scopes) {
    $lease = Get-DhcpServerv4Lease -ComputerName $dhcpServer -ScopeId $scope.ScopeId | Where-Object { $_.ClientId -eq $macAddress }
    if ($lease) {
        break
    }
}

if ($lease) {
    Write-Output "IP Address: $($lease.IPAddress)"
} else {
    Write-Output "No lease found for MAC address $macAddress"
}
