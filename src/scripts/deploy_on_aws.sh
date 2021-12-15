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
whoami
$SUDO ~/bin/aws configure set aws_access_key_id "$AWS_ACCESS_KEY" --profile "$AWS_PROFILE"
$SUDO ~/bin/aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$AWS_PROFILE"
$SUDO ~/bin/aws ec2 authorize-security-group-ingress --region "$AWS_DEFAULT_REGION" --group-id "$SG_ID" --protocol tcp --port 22 --cidr "$PUBLIC_IP"/24
$SUDO sleep 10
echo "Added ingress rule to aws"