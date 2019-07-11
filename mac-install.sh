#!/usr/bin/env bash

# This install script is intended to download and install the latest available
# developer tools to assist with running commands in the terminal.
# 
# You can install using this script:
# $ curl https://raw.githubusercontent.com/anthonygaliamov/Developer-Tools/Fedora-Install-Scripts/mac-install.sh | sh

# Run installations with admin access
# Enter sudo (admin)
echo -e "\nEnter your system password below."

# Install PIP
sudo easy_install pip
sudo pip install --upgrade pip
echo -e "\nPIP has been installed. Installation of PIP pre-requisites will begin now. \n"

# Install PIP Pre-Requisites
sudo pip install requests
sudo pip install importlib
sudo pip install PyYAML
echo -e "\nInstallation of PIP pre-requisites complete. \n"

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
echo -e "\nHomebrew has been installed. For further assistance run 'brew help'. \n"

# Install Z Shell (zsh)
brew install zsh
chsh -s $(which zsh)
echo -e "\nZ Shell installed. The terminal has been defaulted to use zsh instead of bash."
# Make bash default
# chsh -s $(which bash)

# Install Alfred
brew cask install alfred
echo -e "\nAlfred has been installed. Open Alfred using Spotlight to complete setup. \n"

# Install Java
# brew cask install java

# Install Ansible
brew install ansible
echo -e "\nAnsible has been installed. \n"

# Install VirtualBox
brew cask install virtualbox

# Install Kubernetes
brew install kubectl
rm /usr/local/bin/kubectl
brew link --overwrite kubernetes-cli

brew install gnu-tar

git clone https://github.com/kubernetes/kubernetes
# cd kubernetes
# make quick-release
echo -e "\nKubernetes has been installed. For further assistance run 'kubectl --help'. \n"

# Install Minikube
brew cask install minikube
brew install hyperkit
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/
minikube start --vm-driver hyperkit

# Install Mark Text
brew cask install mark-text
echo -e "\nMark Text has been installed. Search for it using Spotlight (Cmd + Spacebar)\n"

# Install Node.js and npm
brew install node
echo -e "\nNode.js and npm have been installed. \n"

# Install Ruby
brew install ruby

# Install vmd
npm install -g vmd
echo -e "\nvmd has been installed. Run 'vmd (Filename - If not included, defaults to README.MD)' to open .md files. \n"






# echo -e "\n has been installed. For further assistance run ''. \n"