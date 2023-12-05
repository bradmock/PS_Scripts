# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the username of the manager whose direct reports you want to retrieve
$managerUsername = "PKincade"

# Get the user object for the manager
$manager = Get-ADUser -Identity $managerUsername -Properties DirectReports, AccountExpirationDate

# Check if the manager has direct reports
if ($manager.DirectReports) {
    # Create an array to store the results
    $results = @()

    # Loop through each direct report
    foreach ($directReport in $manager.DirectReports) {
        # Get the user object for the direct report
        $user = Get-ADUser -Identity $directReport -Properties SamAccountName, DisplayName, AccountExpirationDate

        # Create an object with the required information
        $reportInfo = [PSCustomObject]@{
            'Direct Report Display Name' = $user.DisplayName
            'Direct Report Username'     = $user.SamAccountName
            'Account Expiration Date'    = $user.AccountExpirationDate
        }

        # Add the object to the results array
        $results += $reportInfo
    }

    # Export the results to a CSV file
    $results | Export-Csv -Path "c:\temp\7DirectReportsInfo.csv" -NoTypeInformation
    Write-Host "Direct reports information exported to DirectReportsInfo.csv."
} else {
    Write-Host "The manager has no direct reports."
}

# Remove the Active Directory module
Remove-Module ActiveDirectory
