# Get/Set Admin User Credentials

$AdminUser = "mylinuxadmin"
$AdminPass = 'My5upperP@ss'

$AdminUser = "guruadmin"
$AdminPass = "GuruSecretP@ss"

If ($AdminUser -eq "" -or $AdminPass -eq "") {
    Write-host "In the popup box, Please enter username and password you would like to use for the Virtual Machine" -ForegroundColor Yellow
    $Credential = Get-Credential  
    # Get-Credential will crash if user presses escape ... neeed to add traps later.
    If ( $Credential -eq $null ) { 
        Write-host "Unable to continue without machine credentials" -ForegroundColor Red
        break 
        #Exit
    } 
}
Else {
    $securePassword = ConvertTo-SecureString $AdminPass -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential ($AdminUser, $securePassword)
    }
        Write-Host "Credentials Entered! " -ForegroundColor Green