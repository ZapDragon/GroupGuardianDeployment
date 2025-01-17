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
        InstallPowerShell
    fi

    GetPayload
}

# Get and install Powershell - Yes, PowerShell. Judge me all you want.
function InstallPowerShell
{
    echo "Installing PowerShell"
    curl -s https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell_7.4.6-1.deb_amd64.deb -o pwsh_7.4.6.deb
    dpkg -i pwsh_7.4.6.deb
    apt install -f
    rm pwsh_7.4.6.deb
    echo "Installed PowerShell"
}

# Get the Endpoint URL, and execute the downloaded payload.
# Any errors here, and this script will exit without any other prompts.
function GetPayload
{
    if [[ "$GGEP" != $null && "$GGEP" != "" ]]; then
        echo "EndPoint is $GGEP"
        curl -s $GGEP -o Payload.ps1
        pwsh -f ./Payload.ps1
    else
        echo "You must specificy an endpoint as an argument to this script"
    fi
}

Init
