#!/bin/sh

INSTALL_FOLDER=/opt/pode/
PWSH_EXE=/usr/bin/pwsh

if [ "$EUID" -ne 0 ]
then
    echo "Please run as root"
    exit
fi

if [ ! -f "$PWSH_EXE" ]; then
    echo "PowerShell not installed. Please install PowerShell before running this script."
    exit 1
fi

cp mockapi-server.service /etc/systemd/system/
mkdir $INSTALL_FOLDER
cp MockApiServer.ps1 $INSTALL_FOLDER
systemctl enable mockapi-server
systemctl start mockapi-server
