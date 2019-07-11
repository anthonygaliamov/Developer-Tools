# Getting Started with Ansible

For this we are going to be using macOS with a virtual machine running Ubantu.

#### YAML Basics

YAML (Yet Another Markup Language)

```yaml
# Starts with --- to begin the document. This defines the document as a YAML file.
---
# Start with a YAML dictionary
name: Anthony
country: Australia

# Can be expanded with a YAML list.
- Anthony
- Sarah
- James

name:
    - Anthony
    - Sarah
    - James

name: ['Anthony','Sarah','James']

# String with YAML
name: "{{My Name is James}}"
```

To install Ansible we need a Linux OS or VM. Most of us would probably be picking the VM option, so lets go through how we set this up.

1. Download VirtualBox

2. Download Vagrant

3. Run this command to download and deploy a Linux distro.

```bash
# First we want to create a folder for our VM and navigate to it.
% mkdir -p /Users/$USER/Virtual\ Machines/Vagrant && cd $_
% vagrant init ubuntu/trusty64; vagrant up --provider virtualbox
# We can now connect to our VM.
% vagrant ssh
```

Now we are going to be installing Ansible.

```bash
% sudo -i
% apt-add-repository ppa:ansible/ansible
% apt-get update
% apt-get install ansible
% ansible --version
```
