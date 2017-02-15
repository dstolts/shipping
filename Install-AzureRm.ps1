<#   
========= Install-AzureRm.ps1 ======================================= 
 Name: Install-AzureRm 
 Purpose: Check to see if AzureRM module is installed.  If not install it.
    
 NOTE: Requires Powershell to be run as an administrator

 Author: Dan Stolts - dstolts&microsoft.com - http://ITProGuru.com
         Script Home: http://ITProGuru.com/Scripts 
 ================================================================================ 
#># 

# Install the Azure Resource Manager modules from the PowerShell Gallery (if not already done)
If ((Get-Module AzureRM.Compute) -eq $null) 
 {
     Write-Host "Installing AzureRM PowerShell Module" -ForegroundColor Green
     Install-Module AzureRM -Force -AllowClobber
     Write-host "Finished" -ForegroundColor Green}
 else {Write-Host "AzureRM Module already installed" -ForegroundColor Green}   

