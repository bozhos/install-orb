if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

export DOTNET_APP_DIRECTORY="$PARAM_DOTNET_APP_DIRECTORY"
export ZIP_DIR="${DOTNET_APP_DIRECTORY}_${CIRCLE_SHA1}.zip"
export SSH_LOGIN="ubuntu@${EC2_PUBLIC_DNS}"
export AWS_PROFILE="default"

$SUDO pwd
$SUDO ls -la
$SUDO echo "$ZIP_DIR"
$SUDO ls -l
PUBLIC_IP=$(curl ipinfo.io/ip)
echo "$PUBLIC_IP"
echo "$SSH_LOGIN"
#$SUDO ~/bin/aws ec2 authorize-security-group-ingress --region "$AWS_DEFAULT_REGION" --group-id "$SG_ID" --protocol tcp --port 22 --cidr "$PUBLIC_IP"/32
whoami
$SUDO ~/bin/aws configure set aws_access_key_id "$AWS_ACCESS_KEY" --profile "$AWS_PROFILE"
$SUDO ~/bin/aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$AWS_PROFILE"
$SUDO ~/bin/aws ec2 authorize-security-group-ingress --region "$AWS_DEFAULT_REGION" --group-id "$SG_ID" --protocol tcp --port 22 --cidr "$PUBLIC_IP"/32
$SUDO sleep 5
echo "$EC2_PUBLIC_DNS"
$SUDO ssh -o StrictHostKeyChecking=no "$SSH_LOGIN"  "sudo systemctl stop test-app.service"
$SUDO cat "$ZIP_DIR" | ssh -o StrictHostKeyChecking=no "$SSH_LOGIN" "cat > $ZIP_DIR"
$SUDO ssh -o StrictHostKeyChecking=no "$SSH_LOGIN" "sudo unzip -o $ZIP_DIR -d /opt/"
$SUDO ssh -o StrictHostKeyChecking=no "$SSH_LOGIN"  "sudo systemctl start test-app.service"
