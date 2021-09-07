# Toru

## What it is ?

Toru is an minimal aur helper. It stores the clones of the aur git-repos in an folder chosen by user.

## What does the name mean ?

Since the standard package manager is called pacman, we looked for a name that has something to do with the game. Toru Iwanti was the developer in charge for the pacman game, so we decided to honor him by naming our aur-helper after him.

## Why another AUR helper ?

There are a ton of aur helpers out there so why do we write another one? The simple answer is simplicity and control. The main difference between Toru and the other aur-helpers is, that toru does anything only if the user explicitly commands it.

## How it works ?

Toru works by storing the clones of the aur git repos in an designated folder. We recommend `~/Downloads/AUR/`.
Toru will:
- look for updates on command
- install updates on command (specific packages or all)
- clean the compilation after installing
- remove packages on command
- install aur packages by git link

One important thing is that Toru will install packages only via giving a link. That is one decision we took and in our oppiniomn the biggest advantage. The user does know at any point in time what exactly will be installed.

## Installation

There are two ways of installing toru on your system.

### Put in bin

The first is to copy the `toru.sh` to your binary folder. And give in execution rights.

```bash
git clone https://github.com/JavelinHurler/toru.git toru && cd toru
cp toru.sh /usr/bin/toru
chmod +x /usr/bin/toru
```

### Create alias

The second way is to put the toru script to any dir on your file system and to create an alias to run it.

```bash
git clone https://github.com/JavelinHurler/toru.git toru && cd toru
cp toru.sh ~/toru.sh
chmod +x ~/toru.sh
```

This is one example with an given path. you can change path to toru.sh.

```bash
# in any file where the aliases are set add the following
alias toru="bash ~/toru.sh"
```


## Usage
```
toru update <list of package names>
	update given packages
	(if no packages are given all packages get an update)

toru install <link to git repo> <name>
	installs given aur package by git link
	name: name of the git folder in aur folder

toru check-update
	prints list of aur packages that have an update

toru list
	prints list of folders in AUR directory
```

## Contributing

If you see any error, bug, typo or you have just an idea how to improve Toru, feel free to contribute.

## Next steps

- [ ] Use PKG nameing of the packages
    - now there are two names for every package: the one of the folder and the one of the package controlled by pacman
    - in download process first give an temp folder name and then rename to pkh name
    - in list command give alternate color if folder is not an valid package
- [ ] matching of packages and aur folders
    - add an file in aur folder that contains the folders that are valid installed packages
    - in list commands use this file
    - add clean command to delete folders and files from aur dir toru has no track of
- [ ] create delete command to delete package from pacman and from aur dir
    - check function that matches aur dir folders to pacman -Q output which should be run every time to make shure the packages are still installed
