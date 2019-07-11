#!/bin/bash

# This install script is intended to download and install the latest available
# developer tools to assist with running commands in the terminal.
# 
# You can install using this script:
# $ curl https://raw.githubusercontent.com/anthonygaliamov/Developer-Tools/Fedora-Install-Scripts/fedora-install.sh | sh

# Scripts assume you have enabled `sudo` without password.

# Install Z Shell (zsh)
sudo yum install zsh
chsh -s $(which zsh)
echo -e "\nZ Shell installed. The terminal has been defaulted to use zsh instead of bash."
# Make bash default
# chsh -s $(which bash)

# Install Node.js
sudo dnf install nodejs
echo -e "\nNode.js has been installed. \n"

# Install Yarn
sudo npm install yarn -g


# Install Go
sudo yum install dep


# Install Docker
# Remove older versions
sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine
# Setup the repository for Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# Install Docker CE
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo usermod -aG docker $USER
# docker run hello-world
echo -e "\nDocker has been installed. \n"

# Install OpenShift Client (OC)
sudo dnf install origin-clients docker
echo -e "\nOpenShift Client has been installed. \n"

# Install Kubernetes
sudo dnf -y install kubernetes
sudo dnf -y install etcd




sudo dnf install -y containerd
sudo dnf install -y ./docker-ce-cli-19.03.0-1.1.beta1.fc30.x86_64.rpm
sudo rpm -i --nodeps ./docker-ce-19.03.0-1.1.beta1.fc30.x86_64.rpm

# Install Sublime Text Editor
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text



# Removed cached packages
dnf clean packages



## Install Google Chrome
sudo su -

vi /etc/yum.repos.d/google-chrome.repo

# Paste the below and exit vi with the escape key and :wq
[chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

dnf install -y google-chrome-stable
exit # Exit sudo



