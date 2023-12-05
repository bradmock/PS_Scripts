# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the text file containing full names (one name per line)
$listFilePath = "C:\Temp\brs_userlist.txt"

# Output CSV file path
$outputCsvPath = "C:\Temp\brs_userlistUPN.csv"

# Check if the file exists
if (Test-Path $listFilePath -PathType Leaf) {
    # Read the full names from the file
    $fullNames = Get-Content $listFilePath

    # Array to store results
    $results = @()

    # Loop through each full name and get the UPN
    foreach ($fullName in $fullNames) {
        $user = Get-AdUser -Filter {DisplayName -eq $fullName} -Properties UserPrincipalName

        if ($user) {
            $upn = $user.UserPrincipalName
            $result = [PSCustomObject]@{
                'Full Name' = $fullName
                'UPN' = $upn
            }
            $results += $result
            Write-Host "Full Name: $fullName, UPN: $upn"
        } else {
            Write-Host "User not found for full name: $fullName"
        }
    }

    # Export results to CSV
    $results | Export-Csv -Path $outputCsvPath -NoTypeInformation
    Write-Host "Results exported to: $outputCsvPath"
} else {
    Write-Host "File not found: $listFilePath"
}
