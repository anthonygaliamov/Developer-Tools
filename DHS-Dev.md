# How to be able to do anything at DHS

#### Get KeePass

To be able to access the ISAM console, you need login keys. To get these you will need the following file.
KeyPass File: \\DCVSFS4.internal.dept.local\dcvsfs4-shared-61015398\MAISIS\SOAPE Team\ISAM\tools
Master Password: SoapeManage1!

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


## Get GitLab Access
Get a GitLab account.

Go to (ISP)[https://isp.csda.gov.au/idm].
Click Work Dashboard tab at the top of the page.
Click Make a Process Request button on the left hand side.
Select All from the Process Request Category list.
Select Request Resource from the Process list.
Under Form Detail, enter a reason for the request.
Under Search Criteria, click the search icon next to Categories.
Expand ACF (SAMS) from the list by clicking the +
Expand PROD from the list by clicking the +
Select GITLAB.
Ensure Filter By is set to Name.
Under Containing, type GITLAB-Users and click Search.
Under Search Results, select GITLAB-Users.
Click the right arrow to add it to Resources To Request.
If you only want guest access to GitLab, click Submit. If you want
editing rights to your team's group within GitLab, continue on to the next
steps.
Search for your team by one of the following terms into the Containing field:

If you are in Service Operations Branch search SOB.
If you are in Infrastructure and Application Engineering Branch search
IAEB

Select your team in the left-hand pane and click the right arrow
to add it to Resources To Request.
Click Submit.
To gain access to the Git development tools you will need to request the git-dev-tools resource in ISP. This is done by doing the following:

Request Git-Dev-Tools in ISP
Go to (ISP)[https://isp.csda.gov.au/idm].
Click Work Dashboard tab at the top of the page.
Click Make a Process Request button on the left hand side.
Select All from the Process Request Category list.
Select Request Resource from the Process list.
Under Form Detail, enter a reason for the request.
Under Search Criteria, click the search icon next to Categories.
Expand Active Directory from the list by clicking the +
Select Desktop Application.
Ensure Filter By is set to Name.
Under Containing, type Git-Dev and click Search.
Under Search Results, select Git-Dev-Tools.
Click the right arrow to add it to Resources To Request.
Click Submit.
