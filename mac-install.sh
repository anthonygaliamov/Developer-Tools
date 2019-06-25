#!/bin/bash

# This install script is intended to download and install the latest available
# developer tools to assist with running commands in the terminal.
# 
# You can install using this script:
# $ curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Run installations with admin access
# Enter sudo (admin)
echo -e "\nTo be able to run and install several of these applications, we need admin access. \nOnce installed root will be exited. \nEnter your system password below."
sudo -i

# Install PIP
easy_install pip
pip install --upgrade pip
echo -e "\nPIP has been installed. Installation of PIP pre-requisites will begin now. \n"

# Install PIP Pre-Requisites
pip install requests
pip install importlib
pip install PyYAML
echo -e "\nInstallation of PIP pre-requisites complete. \n"

# Install oc (OpenShift Client)
curl -LO https://raw.githubusercontent.com/anthonygaliamov/ISAM-Cookbook/master/README.md
chmod +x ./README.md
mv ./README.md /usr/local/bin
echo -e "\nOC has been installed. \n"

# Exit sudo (admin)
exit

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo -e "\nHomebrew has been installed. For further assistance run 'brew help'. \n"

# Install Java
# brew cask install java

# Install Ansible
brew install ansible
echo -e "\nAnsible has been installed. \n"

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

# Install Kubernetes
brew install kubernetes-cli
echo -e "\nKubernetes has been installed. For further assistance run 'kubectl --help'. \n"









# echo -e "\n has been installed. For further assistance run ''. \n"