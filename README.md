Juanra Nunez dotfiles
========

These are config files to set up a system the way I like it. I switched to ZSH shell + Oh My ZSH!

I am running on Mac OS X, but the `tools/install.sh` script takes into consideration Linux environments to configure terminal shells on cloud servers, e.g. DigitalOcean, Amazon AWS, etc.

## Installation

Run the following commands to execute `tools/install.sh` script in your terminal:

```
git clone git@github.com:juanra/dotfiles.git ~/.dotfiles
chmod +x ~/.dotfiles/tools/install.sh
. ~/.dotfiles/tools/install.sh
```

After installing Oh My ZSH!, use the `exit` command to continue the installation and setup of the .zshrc config file, and restart the terminal to see the effects.

Feel free to customize the .zshrc file to match your preferences.

## ZSH Shell

The Z shell (zsh) is a Unix shell that can be used as an interactive login shell and as a powerful command interpreter for shell scripting. Zsh is an extended Bourne shell with a large number of improvements, including some features of bash, ksh, and tcsh.

### ZSH config file

After installation, you will find the `.zshrc` config file in the following path:

`
~/.zshrc
`

## Oh My ZSH!

A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. [http://ohmyz.sh/](http://ohmyz.sh)

After installation, you will find OMZ! directory at the following path:

`
~/.oh-my-zsh
`
