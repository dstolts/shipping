#Prepare for docker remote connection on the machine you will be connecting from (full GUI, not Nano)
# From your Laptop or server you will be using to connect to nano...
#Download Docker Engine
Invoke-WebRequest "https://download.docker.com/components/engine/windows-server/cs-1.12/docker.zip" -OutFile "$env:TEMP\docker.zip" -UseBasicParsing
Expand-Archive -Path "$env:TEMP\docker.zip" -DestinationPath $env:ProgramFiles
Write-Host "Please manually run client installation from $env:ProgramFiles\docker" -ForegroundColor Green
