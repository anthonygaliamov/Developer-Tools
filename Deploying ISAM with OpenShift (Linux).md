# Deploying ISAM with OpenShift (Linux)

To begin, you first need a Linux environment to work in.
For this, I'm using fresh installation of Fedora, but RH Linux 8 or CentOS should also be fine.

If you are running Linux inside a VM, I would reccommend running the VM with these minimum settings. Anything less and you will not be able to deploy ISAM.

| Virtual Machine | Setting           |
| --------------- | ----------------- |
| Processor (CPU) | 6 processor cores |
| RAM             | 8GB               |
| Disk-size       | 120GB             |

#### Installing Prerequisites

Once you have a Linux environment up and running, the following dependencies must be installed on your system.

```bash
$ sudo yum install golang-bin gcc-c++
```

> If you get an error where your user ID is "not in the sudoers file" you can run the following to configure `sudo` access.
> 
> ```bash
> $ su
> $ usermod -aG wheel $USER
> # Logout and log back in to your Linux OS.
> # You will now be able to run `sudo` commands.
> ```
> 
> You can also configure `sudo` to not ask for a password. This should only be done in a VM as this would be considered too much of a security risk for most situations.
> 
> ```bash
> $ sudo vi /etc/sudoers
> ```
> 
> The file contains the below two lines, comment out the first `%wheel` line and uncomment the second.
> 
> ```bash
> ## Allows people in group wheel to run all commands
> # %wheel ALL=(ALL) ALL
> 
> ## Same thing without a password
> %wheel ALL=(ALL) NOPASSWD: ALL
> ```
> 
> Exit the file with `:wq!`

#### Installing Go

Dependencies are managed with `dep` and are committed directly to the reposity.

```bash
$ sudo yum install dep
# Once `dep` has been installed we need to add a new dependancy.
$ dep ensure
```

#### Installing KVM

Minishift requires a [hypervisor](https://docs.okd.io/latest/minishift/getting-started/setting-up-virtualization-environment.html) to start the virtual machine on which the OpenShift cluster is provisioned. Because I am running Linux, I'll use [KVM](https://www.redhat.com/en/topics/virtualization/what-is-KVM) which will convert Linux into a type-1 (bare-metal) hypervisor.

```bash
# Install libvirt and qemu-kvm.
$ sudo dnf install libvirt qemu-kvm
# Add yourself to the libvirt group.
$ sudo usermod -a -G libvirt $USER
# Update the current session.
$ newgrp libvirt

# As root, install the KVM driver binary.
$ sudo -i
# Enter your password.
# Run the below command to download the KVM driver.
$ curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
# Make the KVM driver executable.
$ chmod +x /usr/local/bin/docker-machine-driver-kvm
$ logout
```

We now need to **start the libvirtd service** and ensure it is configured.

```bash
# Check to see if the service is "Active".
$ systemctl is-active libvirtd
# If the service is not active, run the following command.
$ sudo systemctl start libvirtd

# Check to see if the libvirt network is set-up.
$ sudo virsh net-list --all
# If default had a state that is not active or autostart is not yes, run the following commands.
$ sudo virsh net-start default
$ sudo virsh net-autostart default
```

#### Installing VirtualBox

Next we need to install VirtualBox which will provide us with a way to manage the Minishift VM. To download and install VirtualBox for Linux, visit [www.virtualbox.org](https://www.virtualbox.org/wiki/Linux_Downloads)

Alternatively, you can run the below commands.

```bash
# Install Dependencies
$ sudo dnf -y install @development-tools
$ sudo dnf -y install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras

# Create the VirtualBox RPM repository.
$ cat <<EOF | sudo tee /etc/yum.repos.d/virtualbox.repo
 [virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/29/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOF

# Import the VirtualBox GPG Key. This will sign the package.
$ sudo dnf search virtualbox
# Install VirtualBox.
$ sudo dnf install VirtualBox-6.0

# Add yourself to the vboxusers group.
$ sudo usermod -a -G vboxusers $USER
$ newgrp vboxusers
# Check to see if you've been added to the group.
$ id $USER
```

#### Installing Minishift

You can download the latest version of Minishift from the [Minishift releases](https://github.com/minishift/minishift/releases) page and manually move the `minisift` binary to the `$PATH` environment.

Alternatively, you can run the below commands.

```bash
# Download the file.
$ curl -L https://github.com/minishift/minishift/releases/download/v1.34.0/minishift-1.34.0-linux-amd64.tgz -o /tmp/minishift-1.34.0-linux-amd64.tgz
# Extract the file into the /tmp folder.
$ tar xvf /tmp/minishift-1.34.0-linux-amd64.tgz -C /tmp
# Move the `minishift` binary to the $PATH environment.
$ sudo mv /tmp/minishift-1.34.0-linux-amd64/minishift /usr/local/bin
# Confirm minishift works.
$ minishift version
```

We need to now install the **kernel-devel** driver.

```bash
$ sudo dnf --refresh install kernel-devel
```

#### Installing OpenShift Client

You can download the latest version of OpenShift from [OpenShift releases](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/) page and manually move the `oc` and `kubectl` binary to the `$PATH` environment.

Alternatively, you can run the below commands.

```bash
# Download the file.
$ curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.1.3.tar.gz -o /tmp/openshift-client-linux-4.1.3.tar.gz
# Extract the file
$ tar xvf /tmp/openshift-client-linux-4.1.3.tar.gz -C /tmp
# Move the `oc` and `kubectl` binary to the $PATH environment.
$ sudo mv /tmp/oc /tmp/kubectl /usr/local/bin
```

After `oc` and `kubectl` have been added to the `$PATH` environment, we need to install the Docker clients. To do this, run the below command.

```bash
# Install Docker clients. The `--allowrasing` string will replace any conflicting packages.
#$ sudo dnf install origin-clients docker --allowerasing
```

#### Starting Minishift

To get started, we need to make a few tweaks to the virtual machine.
Note that the lower the values are, the more likely we will run into issues with OpenShift.

```bash
# Use virtualbox instead of KVM.
$ minishift config set vm-driver virtualbox

# The below commands are optional.
# Memory default: 4G
$ minishift config set memory 8G 
# CPU default: 2
$ minishift config set cpus 4
# Disk-size default 20G
$ minishift config set disk-size 100G
```

After we made the config tweaks, we can start our VM.

```bash
# Bring up the VM and OpenShift Cluster.
$ minishift start
# Once the machine is ready, we need to set the path of the 'oc' binary.
$ eval $(minishift oc-env)
# Open the OpenShift console.
$ minishift console
```

> If you have issues starting Minishift, try deleting the Minishift configuration and starting it again.
> 
> ```bash
> $ minishift delete
> $ minishift start
> ```
> 
> You can always **check the status** of `minishift` or `oc` by running the following commands.
> 
> ```bash
> # Get status of Minishift
> $ minishift status
> # Get status of OpenShift
> $ oc get pods
> ```

#### Deploy ISAM using OpenShift

To set-up an environement for ISAM using OpenShift, use the files in...

```bash
# Grant user access to the sudoers group.
$ oc login -u system:admin -n default
$ oc adm policy add-role-to-user sudoer developer
# Set-up the security context constaints.
$ ./setup-security.sh
# Provide OpenShift with our Docker credentials.
$ ./create-docker-store-secret.sh
# Create the secrets for the environment.
$ ./create-secrets.sh
# Process the YAML Template to create our pods in OpenShift.
$ oc process -f sam-openshift-template.yaml | oc create -f -
```

  Before we proceed any futher, it's a good idea to open the OpenShift console and check our pods.

```bash
./lmi-access.sh
```
