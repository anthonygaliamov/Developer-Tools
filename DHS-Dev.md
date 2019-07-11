# How to be able to do anything at DHS

#### Install Git Bash (Windows)

2. Open a the following path in a new explorer window.
   
   `T:\GIT`

3. Run the latest version of Git Bash and click through the installation wizard.

#### Generate a new SSH Key Pair

We now need to generate a public and private key which we can share with GitLab.

2. Open Git Bash and run the following command.

```bash
$ ssh-keygen -t ed25519
```

3. You will be prompted wish a message asking you where you would like to save your keys. Press the enter key.
   
   This will be saved in the following path `C:\Users\"YOUR USERNAME"\.ssh`

4. You'll be asked to enter a password. It's not really nesscessary in our case, so press the enter key twice to continue.
