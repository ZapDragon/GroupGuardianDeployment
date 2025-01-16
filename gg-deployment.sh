#!/bin/env sh

## Group Guardian Node Bootstrap

#
# The Purpose of this script is to allow an easy method to automatically deploy additional GG Nodes should it ever be required.
# This script is useless to anyone without any access to, or refrences to the ACTUAL deployment script(s)
# In essence, This script is for the convience of Guardian LLC staff, and thats it.
#

# First function called, after script init.
function Init()
{
	if [ $(which pwsh) ]; then
		echo "PowerShell is already installed"
	else
		InstallPowerShell
	fi
	
	Execute
}

# Get and install Powershell - Yes, PowerShell. Judge me all you want.
function InstallPowerShell()
{
	echo "Installing PowerShell"
	wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell_7.4.6-1.deb_amd64.deb
	dpkg -i powershell_7.4.6-1.deb_amd64.deb
	apt install -f
	rm powershell_7.4.6-1.deb_amd64.deb
	echo "Installed PowerShell"
}

# Get the Endpoint URL, and execute the downloaded payload.
# Any errors here, and this script will exist without any other prompts.
function Execute
{
	read -p "Please provide an endpoint: " GGEP
	curl -s $GGEP -o Payload.ps1
	pwsh -f ./Payload.ps1
	exit
}

Init