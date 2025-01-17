## Group Guardian Node Bootstrap

#
# The Purpose of this script is to allow an easy method to automatically deploy additional GG Nodes should it ever be required.
# This script is useless to anyone without any access to, or refrences to the ACTUAL deployment script(s)
# In essence, This script is for the convience of Guardian LLC staff, and thats it.
#

# First function called, after script init.
function Init
{
    apt update
    apt full-upgrade -y
    apt install curl beep -y
    clear
    if [ $(which pwsh) ]; then
        echo "PowerShell is already installed"
    else
		# Get and install Powershell - Yes, PowerShell. Judge me all you want.
        echo "Installing PowerShell"
		curl -s https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell_7.4.6-1.deb_amd64.deb -o pwsh_7.4.6.deb
		dpkg -i pwsh_7.4.6.deb
		apt install -f
		rm pwsh_7.4.6.deb
		echo "Installed PowerShell"
    fi
	
	cat <<EOF > ./ggps-bootstrap.ps1
# GG PS BOOSTRAP
Invoke-WebRequest -Uri (Read-Host 'EndPoint') -OutFile ./GGDeployment.ps1
Import-Module ./GGDeployment.ps1
EOF
	clear
	echo 'PS1 Bootstrap saved. Run "pwsh -Interactive -f ./ggps-bootstrap.ps1" to begin deployment.'
}

Init