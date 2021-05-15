# Deploying ISAM with OpenShift (macOS)

To run OpenShift on macOS you will need to ensure you have a few prerequisites installed and running. Note that some of these programs may already be installed and configured.

For this example, I'm running macOS Catalina 10.15.

> If you are running an older version of macOS that uses bash, you can run the following command to install Z Shell.
> 
> ```bash
> # Install Z Shell (zsh)
> $ brew install zsh
> # Set Z Shell as default
> chsh -s $(which zsh)
> ```

#### Installing Prerequisites

Once you have a Linux environment up and running, the following dependencies must be installed on your system.

```bash
# Install Homebrew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install Cask
$ brew tap caskroom/cask
```

#### Installing xhyve

Minishift requires a [hypervisor](https://docs.okd.io/latest/minishift/getting-started/setting-up-virtualization-environment.html) to start the virtual machine on which the OpenShift cluster is provisioned. Because we are running macOS, we'll use xhyve which is built on top of [Hypervisor.framework](https://developer.apple.com/library/mac/documentation/DriversKernelHardware/Reference/Hypervisor/index.html) in macOS 10.10 Yosemite and higher.

> You will need MacPorts installed before running the below commands.
> To download the latest version of MacPorts, visit the [MacPorts Release](https://github.com/macports/macports-base/releases/tag/v2.5.4 "Available Downloads") page.

```bash
# Installing xhyve. The `--HEAD` in the command ensures we always have the latest version.
$ brew install --HEAD xhyve
# Update our MacPorts.
#$ sudo port selfupdate
#$ sudo port install xhyve

# Install xhyve driver for Docker.
$ brew install docker-machine-driver-xhyve
# Enable root access for the `xhyve` binary.
$ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
# Set the owner User ID (SUID)
$ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
```

#### Installing Hyperkit

Next we need to install Hyperkit and its Docker driver.

```bash
# Install Hyperkit.
$ brew install hyperkit
# Install Hyperkit driver for Docker.
$ brew install docker-machine-driver-hyperkit
# Enable root access for the `xhyve` binary.
$ sudo chown root:wheel /usr/local/opt/docker-machine-driver-hyperkit/bin/docker-machine-driver-hyperkit
# Set the owner User ID (SUID)
$ sudo chmod u+s /usr/local/opt/docker-machine-driver-hyperkit/bin/docker-machine-driver-hyperkit
```

#### Installing VirtualBox

Next we need to install VirtualBox which will provide us with a way to manage the Minishift VM. To download and install VirtualBox for macOS you can run the following command or visit [www.virtualbox.org](https://www.virtualbox.org/wiki/Linux_Downloads).

Alternatively, you can run the below command.

```bash
$ brew cask install virtualbox
```

#### Installing Minishift

You can download the latest version of Minishift from the [Minishift releases](https://github.com/minishift/minishift/releases) page and manually move the `minisift` binary to the `$PATH` environment.

Alternatively, you can run the below commands.

```bash
# Install Minishift
$ brew cask install minishift
# Confirm minishift works.
$ minishift version
```

#### Installing OpenShift Client

You can download the latest version of OpenShift from [OpenShift releases](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/) page and manually move the `oc` and `kubectl` binary to the `$PATH` environment.

Alternatively, you can run the below commands.

```bash
# Download the file.
$ curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-mac-4.1.4.tar.gz -o /tmp/openshift-client-mac-4.1.4.tar.gz
# Extract the file
$ tar xvf /tmp/openshift-client-mac-4.1.4.tar.gz -C /tmp
# Move the `oc` and `kubectl` binary to the $PATH environment.
$ sudo mv /tmp/oc /tmp/kubectl /usr/local/bin
```

#### Starting Minishift

To get started, we need to make a few tweaks to the virtual machine. Note that the lower the values are, the more likely we will run into issues with OpenShift.

These are the minimum settings I would reccomend.

```bash
$ minishift config set vm-driver virtualbox
$ minishift config set memory 8G
$ minishift config set cpus 4
$ minishift config set disk-size 80G
```

> If you need to reset (untweak) the above, you can run the following command.
> 
> ```bash
> % sudo minishift config unset vm-driver
> ```

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
