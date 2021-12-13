if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

$SUDO apt-get update
$SUDO apt-get install -y python3.8-venv
$SUDO apt-get install -y python-is-python3
$SUDO curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
$SUDO unzip awscli-bundle.zip
$SUDO ./awscli-bundle/install -b ~/bin/aws
$SUDO ls -l
