if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

export DOTNET_VERSION="$PARAM_DOTNET_VERSION"

$SUDO wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
$SUDO dpkg -i packages-microsoft-prod.deb
$SUDO apt-get update
$SUDO apt-get install -y apt-transport-https
$SUDO apt-get update
$SUDO apt-get install -y "dotnet-sdk-$DOTNET_VERSION"
$SUDO apt-get install -y zip gzip tar
$SUDO pwd
$SUDO ls -la