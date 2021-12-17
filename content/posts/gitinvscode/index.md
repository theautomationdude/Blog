--- 

title: "Using Git version control in VSCode" 

date: 2021-12-16T21:48:27+01:00 

draft: false

comments: true

images:

--- 

In a previous post I wrote about how to [install git on the windows operating system](/blog/posts/installgit/). And another post was about how to [get up and running with VSCode](/blog/posts/gettingupandreadywithvscode/). This post will cover some basics on how to work with git, especially in VSCode.


To contribute to a software project, you can clone a repository and then push new code that you have authored to it. Normally this is done by working in different branches, where the main or master branch normally contains the version of the code that will be pushed to the production environment, while all developers work in other branches that get merged into the master/main branch. This way development can be version controlled and be tested without being introduced to the master branch before it's ready.

## Git config
To collaborate with others in Git you must first set some user settings. Open a shell (powershell, vscode integrated shell or the command shell), then type.

`git config --global user.name "My Name"`

(use your own name of course)

`git config --global user.email "my.email@domain.com"`

(use your own email of course)

## Getting the repository clone URL
Go to the repository you want to clone, in this tutorial I'll use Github, but it's pretty much the same in Azure DevOps and Gitlab (and probably all the other flavours of version control repository management services out there). 


In the repository you click the code/clone button, this will copy the clone URL that you will use in Git cli or VSCode. 

![CloneURL](./clone.jpg)

### Now you can either clone the repository by using Git command line interface (cli), or by using the VSCode graphical user interface (GUI). 

## Clone an existing repository with VSCode
In VSCode, you press *Ctrl+Shift+P* to open up the VSCode command palette.

![VSCode Clone](./gitclone.jpg)

Now type Git: Clone and then VSCode will ask you for the cloning url that you copied from the repository clone button.

![VSCode CloneURL](./cloneurlvscode.jpg)

 Paste the url in the box and then select the folder where you want to store your local replica of the repository, the repository will unpacked into a subfolder to this folder that has the same name as the repository. VSCode will ask if you want to add this repository to the current workspace or open it in a new window, personally I prefer using one window per repository that I'm working with.

## Clone an existing repository with Git cli
Use whatever command (or alias) that rocks your boat to set the folder where you want the repository to be cloned into as your current working directory. In this example we will clone to the *ClonedRepos* folder in the user home folder.

```shell
cd ~\ClonedRepos
```
or
```Powershell
Set-Location ~\ClonedRepos
```
(useful aliases for Set-Location are sl or cd)

#### Now clone the repo with the git clone command and pasting in the repository clone url.

```shell
git clone <your cloneurl pasted here>
```

## Stash

## Add

## Commit

## Push

## Pull

## Branch



## VSCode keyboard shortcuts:
https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf


**Next we'll do some Git basics in VSCode! Happy Coding!**

/TheAutomationDude


