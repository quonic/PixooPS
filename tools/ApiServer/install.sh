#!/bin/bash

INSTALL_FOLDER=/opt/pode/
PWSH_EXE=/usr/bin/pwsh
# Check if user is root
if [[ $(id -u) != 0 ]]; then
    echo "Please run as root"
    exit
fi
# Install pwsh
if [ ! -f "$PWSH_EXE" ]; then
    if [[ $(which yum) ]]; then
        majversion=$(lsb_release -rs | cut -f1 -d.)
        fedoraversion=$(rpm -q --queryformat '%{VERSION}\n' fedora-release)
        if [ "$majversion" -eq "7" ]; then
            yum install -y https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
            elif [ "$majversion" -eq "8" ]; then
            yum install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
            elif [ "$fedoraversion" -ge "31" ]; then
            rpm --import https://packages.microsoft.com/keys/microsoft.asc
            curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
            dnf check-update
            dnf install compat-openssl10
            dnf install -y powershell
        fi
        elif [[ $(which apt) ]]; then
        if [ -f /etc/debian_version ]; then
            IFS='.' read -r -a VERSION < /etc/debian_version
            if [[ ${VERSION[0]} == 11 ]]; then
                wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb
                sudo dpkg -i packages-microsoft-prod.deb
                elif [[ ${VERSION[0]} == 10 ]]; then
                wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
                sudo dpkg -i packages-microsoft-prod.deb
                elif [[ ${VERSION[0]} == 9 ]]; then
                apt update
                apt install -y curl gnupg apt-transport-https
                wget https://packages.microsoft.com/config/debian/9/packages-microsoft-prod.deb
                curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
                sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list'
            fi
            apt update
            apt install -y powershell
        fi
        apt update -y
        apt install -y wget apt-transport-https software-properties-common
        if [[ $(lsb_release -rs) == "18.04" ]]; then
            wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
            elif [[ $(lsb_release -rs) == "20.04" ]]; then
            wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
        fi
        dpkg -i packages-microsoft-prod.deb
        apt update -y
        apt install -y powershell
        elif [[ $(which apk) ]]; then
        apk add --no-cache ca-certificates less ncurses-terminfo-base krb5-libs \
        libgcc libintl libssl1.1 libstdc++ tzdata userspace-rcu zlib icu-libs \
        curl
        apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust
        curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-7.2.1-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz
        mkdir -p /opt/microsoft/powershell/7
        tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
        chmod +x /opt/microsoft/powershell/7/pwsh
        ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
    else
        echo "Unknown/Unsupported OS. Please install PowerShell before running this script."
        exit 1
    fi
else
    echo "PowerShell not installed. Please install PowerShell before running this script."
    exit 1
fi

# Install Mock Api Server service
cp mockapi-server.service /etc/systemd/system/
mkdir $INSTALL_FOLDER
cp MockApiServer.ps1 $INSTALL_FOLDER
systemctl enable mockapi-server
systemctl start mockapi-server
