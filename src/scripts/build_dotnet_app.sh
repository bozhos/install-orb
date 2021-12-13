if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

export DOTNET_APP_DIRECTORY="$PARAM_DOTNET_APP_DIRECTORY"

$SUDO pwd
$SUDO ls
$SUDO dotnet publish -o "$DOTNET_APP_DIRECTORY"
$SUDO zip -r "$DOTNET_APP_DIRECTORY"_"$CIRCLE_SHA1".zip "$DOTNET_APP_DIRECTORY"
$SUDO ls -l
