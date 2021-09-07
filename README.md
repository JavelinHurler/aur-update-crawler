# Toru

## What it is

Toru is an minimal aur helper. It stores the clones of the aur git-repos in an folder chosen by user.

## What does the name mean

Since the standard package manager is called pacman, we looked for a name that has something to do with the game. Toru Iwanti was the developer in charge for the pacman game, so we decided to honor him by naming our aur-helper after him.

## Why another AUR helper

There are a ton of aur helpers out there so why do we write another one? The simple answer is simplicity and control. The main difference between Toru and the other aur-helpers is, that toru does anything only if the user explicitly commands it.

## How it works

Toru works by storing the clones of the aur git repos in an designated folder. We recommend `~/Downloads/AUR/`.
Toru will:
- look for updates on command
- install updates on command (specific packages or all)
- clean the compilation after installing
- remove packages on command
- install aur packages by git link

One important thing is that Toru will install packages only via giving a link. That is one decision we took and in our oppiniomn the biggest advantage. The user does know at any point in time what exactly will be installed.

## Contributing

If you see any error, bug, typo or you have just an idea how to improve Toru, feel free to contribute.
