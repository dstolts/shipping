#Upload-AzureRmVHD  
# Add-AzureVhd -Destination "https://<StorageAccountName>.blob.core.windows.net/<ContainerName>/<vhdName>.vhd" -LocalFilePath <LocalPathtoVHDFile>

#Set required variables
$SubscriptionID  = "1942a221-7d86-4e10-9e4b-d5af2688651c"        # Subscription to create storage in
$RGName =  "Ship-0213a"                    # Pops List to select default
$StorageAccountName ="ship0213a"           # Defaults to prompt user
$mySubscription=Select-AzureRmSubscription -SubscriptionId $subscriptionId
$SubscriptionName = $mySubscription.Subscription.SubscriptionName
Set-AzureRmContext -SubscriptionID $subscriptionId
Write-Host "Subscription: $SubscriptionName $subscriptionId " -ForegroundColor Green



# Get Storage Information... Note we already have it above but adding it here in case you did not need to create storage 
$StorageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $rgName -StorageAccountName $StorageAccountName).Value[0] # Get the primary Key 
$StorageContext = New-AzureStorageContext -StorageAccountKey $StorageKey -StorageAccountName $StorageAccountName # Get the Context 
$StorageAccount = Get-AzureRmStorageAccount -StorageAccountName $StorageAccountName  -ResourceGroupName $rgName # Get the Storage Account 
$StorageAccount
$StorageAccountContext

#region Upload-AzureRmVHD
#Select-AzureRmSubscription -SubscriptionId $SubscriptionID -StorageAccountName $StorageAccountContext.StorageAccount

#Get-AzureRmStorageAccount |Format-Table ResourceGroupName, StorageAccountName
#$mySubscription=Select-AzureRmSubscription -SubscriptionId $subscriptionId 

# Upload VHD
$fileName = $OSDiskName
$dir = Get-Location   # Ok to point this to somewhere else...
$fqFileName = "$dir\$filename.vhd"
Write-host "Vhd to upload $fqFileName"
# Create vhds folder
Try {     
    Write-Host "Creating vhds container if it does not already exist"  -ForegroundColor Green
    New-AzureStorageContainer "vhds" -Permission Container -Context $StorageAccountContext -ErrorAction Stop
    }
catch  {
    Write-Host "Warning: Unable to create vhds folder " -ForegroundColor Yellow -NoNewline
    $error[0].exception 
}

# Upload VHD
$UriFileName = $StorageAccountContext.BlobEndPoint + "vhds/" + $filename +".vhd"
Write-Host "Uploading $fqFileName to" -ForegroundColor Green
Write-Host "   Destination: $UriFileName please be patient"  -ForegroundColor Green
Write-Host "... please be patient"  -ForegroundColor Yellow
Try {
    Add-AzureRmVhd -Destination ($StorageAccountContext.BlobEndPoint + "vhds/" + $filename) -LocalFilePath $fqFileName -NumberOfUploaderThreads 2 -ResourceGroupName $RGName -OverWrite -ErrorAction Stop
    Write-Host "Finished Uploading"  -ForegroundColor Green}
Catch {
    Write-Host "Error Uploading: "  -ForegroundColor Red -NoNewline
    Write-host $error[0].Exception -ForegroundColor Red}
#endregion



# Upload VHD
$UriFileName = $StorageAccountContext.BlobEndPoint + "vhds/" + $filename +".vhd"
   Write-Host "Uploading $fqFileName to" -ForegroundColor Green
   Write-Host "   Destination: $UriFileName please be patient"  -ForegroundColor Green
   Write-Host "... please be patient"  -ForegroundColor Yellow
   Add-AzureRmVhd -Destination ($StorageAccountContext.BlobEndPoint + "vhds/" + $filename) -LocalFilePath $fqFileName -NumberOfUploaderThreads 2 -ResourceGroupName $RGName -OverWrite
   Write-Host "Finished uploading $UriFileName" -ForegroundColor Green
#endregion