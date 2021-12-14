if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

export DOTNET_APP_DIRECTORY="$PARAM_DOTNET_APP_DIRECTORY"
export ZIP_DIR="$DOTNET_APP_DIRECTORY"_"$CIRCLE_SHA1"
export SSH_LOGIN="$EC2_USERNAME"@"$EC2_PUBLIC_DNS"

$SUDO pwd
$SUDO ls -la
$SUDO echo "$ZIP_DIR"
$SUDO ls -l
export PUBLIC_IP=$(curl ipinfo.io/ip)
echo "$PUBLIC_IP"
$SUDO bin/aws ec2 authorize-security-group-ingress --region "$AWS_DEFAULT_REGION" --group-id "$SG_ID" --protocol tcp --port 22 --cidr "$PUBLIC_IP"/32
$SUDO sleep 5
$SUDO ssh -o StrictHostKeyChecking=no "$SSH_LOGIN"  "sudo systemctl stop test-app.service"
$SUDO cat "$ZIP_DIR".zip | ssh -o StrictHostKeyChecking=no "$SSH_LOGIN" "cat > "$ZIP_DIR".zip"
$SUDO ssh -o StrictHostKeyChecking=no "$SSH_LOGIN" "sudo unzip -o "$ZIP_DIR".zip -d /opt/"
$SUDO ssh -o StrictHostKeyChecking=no "$SSH_LOGIN"  "sudo systemctl start test-app.service"

