# MacOS Terminal Developer Tools
Install key developer tools to assist with running commands in the terminal.
Below is a list of all the programs that will be installed with a breif explaination of what they do.

1. Install Homebrew
2. Install Node.js and npm
3. Install vmd. Allows you to open .md (Markdown files) in a new window using the vmd command.

This install script is intended to download and install the latest available developer tools to assist with running commands in the terminal.

## Docker must be installed on MacOS before running these.
 
You can install using this script:
$ curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh


#### Run sudo without a password
You can also configure `sudo` to not ask for a password. This should only be done in a VM as this would be considered too much of a security risk for most situations.

```bash
$ sudo vi /etc/sudoers
```

The file contains the below two lines, comment out the first `%wheel` line and uncomment the second.

```bash
## Allows people in group wheel to run all commands
# %wheel ALL=(ALL) ALL

## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL
```

Exit the file with `:wq!`