#!/bin/bash

# Set echo colors
NOCOLOR='\033[0m'
DIM='\e[2m'
ERROR='\033[0;31m'
OK='\033[0;32m'
INFO='\033[0;34m'
WARNING='\033[1;33m'

# Check if ZSH and dependencies are installed
printf "${INFO}Hi there!, I will check if ZSH and its dependencies are installed ${NOCOLOR}\n"
if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    printf "ZSH and its dependencies are ${OK}already installed ${NOCOLOR}\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || brew install git zsh wget || pkg install git zsh wget ; then
        printf "ZSH, WGET and GIT ${OK}Installed ${NOCOLOR}\n"
    else
        printf "${ERROR}Failed to install required dependencies. ${NOCOLOR}Please manually install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi

# Backup original .zshrc file
if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    printf "${INFO}I noticed that a .zshrc file already exists. I'm going to make a backup of the current .zshrc to .zshrc-backup-date ${NOCOLOR}\n"
fi


if [ -d ~/.oh-my-zsh ]; then
    printf "${INFO}Oh!, oh-my-zsh is already installed  ${NOCOLOR}\n"
else
    printf "${OK}Now, I will install Oh My Zsh framework for managing your Zsh configuration ${NOCOLOR}${DIM}\n"
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

cp -f .zshrc ~/

# Installing Oh My Zsh plugins

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    printf "${INFO}Autosuggestions for ZSH are already enabled. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull --ff-only
else
    printf "${OK}Enabling autosuggestions for ZSH ${NOCOLOR}${DIM}\n"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ -d ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ]; then
    printf "${INFO}Syntax highlighting for ZSH is already enabled. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting && git pull --ff-only
else
    printf "${OK}Enabling syntax highlighting for ZSH ${NOCOLOR}${DIM}\n"
    git clone --depth=1 https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    printf "${INFO}Additional completion definitions for ZSH are already enabled. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull --ff-only
else
    printf "${OK}Enabling additional completion definitions for ZSH ${NOCOLOR}${DIM}\n"
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    printf "${INFO}Shell's history search for ZSH are already enabled. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull --ff-only
else
    printf "${OK}Enabling shell's history search for ZSH ${NOCOLOR}${DIM}\n"
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

# Installing Fonts
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf "${OK}Installing Nerd Fonts version of Fira Code ${NOCOLOR}${DIM}\n"
    wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
    wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
    fc-cache -fv ~/.fonts
elif [[ "$OSTYPE" == "darwin"* ]]; then
    printf "${INFO}Installing Nerd Fonts ${NOCOLOR}${DIM}\n"
    brew tap homebrew/cask-fonts
    if brew cask info font-fira-code-nerd-font&>/dev/null; then
        printf "Fira Code Nerd Font ${OK}Installed ${NOCOLOR}\n"
    else
        printf "${ERROR}Failed to install required fonts. ${NOCOLOR}Please go to https://github.com/ryanoasis/nerd-fonts for information about installing Nerd Fonts \n"
    fi
fi

# Installing Oh My Zsh themes
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    printf "${INFO}powerlevel10k theme is already enabled. ${NOCOLOR}I will update this theme to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.oh-my-zsh/custom/themes/powerlevel10k && git pull --ff-only
else
    printf "${OK}Installing powerlevel10k theme. ${NOCOLOR}${DIM}\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Installing command line tools
printf "${OK}Creating ~/.zshtools directory for additional ZSH tools. ${NOCOLOR}${DIM}\n"
mkdir -p ~/.zshtools       # external plugins, things, will be instlled in here

# Installing fzf (general-purpose command-line fuzzy finder)
if [ -d ~/.zshtools/fzf ]; then
    printf "${INFO}Fuzzy finder for ZSH is already installed. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.zshtools/fzf && git pull --ff-only
    ~/.zshtools/fzf/install --all --key-bindings --completion --no-update-rc --64
else
    printf "${OK}Enabling fuzzy finder feature for ZSH ${NOCOLOR}${DIM}\n"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zshtools/fzf
    ~/.zshtools/fzf/install --all --key-bindings --completion --no-update-rc --64
fi

# Installing k (directory listings for zsh with git features)
if [ -d ~/.oh-my-zsh/custom/plugins/k ]; then
    printf "${INFO}Directory listings for zsh with git features are already installed. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.oh-my-zsh/custom/plugins/k && git pull --ff-only
else
    printf "${OK}Enabling directory listings for zsh with git features ${NOCOLOR}${DIM}\n"
    git clone --depth 1 https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
fi

# Installing marker (bookmark commands)
if [ -d ~/.zshtools/marker ]; then
    printf "${INFO}Bookmark commands are already installed. ${NOCOLOR}I will update this feature to the last stable version. ${NOCOLOR}${DIM}\n"
    cd ~/.zshtools/marker && git pull --ff-only
else
    printf "${OK}Enabling bookmark commands ${NOCOLOR}${DIM}\n"
    git clone --depth 1 https://github.com/pindexis/marker ~/.zshtools/marker
fi

if ~/.zshtools/marker/install.py; then
    printf "${OK}Marker Installed ${NOCOLOR}\n"
else
    printf "${ERROR}Failed to install Marker. ${NOCOLOR}Please try to manually install the package and try again.\n" && exit
fi

# Installing EXA (modern replacement for the command-line program ls)
if command -v exa &> /dev/null; then
    printf "EXA is ${OK}already installed ${NOCOLOR}\n"
else
    if sudo pacman -S exa || sudo dnf install -y exa || brew install exa; then
        printf "${OK}EXA Installed ${NOCOLOR}\n"
    else
        printf "${ERROR}Failed to install EXA. ${NOCOLOR}Please try to manually install the package and try again \n" && exit
    fi
fi

# if git clone --depth 1 https://github.com/todotxt/todo.txt-cli.git ~/.zshtools/todo; then :
# else
#     cd ~/.zshtools/todo && git fetch --all && git reset --hard origin/master
# fi
# mkdir ~/.zshtools/todo/bin ; cp -f ~/.zshtools/todo/todo.sh ~/.zshtools/todo/bin/todo.sh # cp todo.sh to ./bin so only it is included in $PATH
# #touch ~/.todo/config     # needs it, otherwise spits error , yeah a bug in todo
# ln -s ~/.zshtools/todo ~/.todo
if [ ! -L ~/.zshtools/todo/bin/todo.sh ]; then
    printf "${INFO}Installing todo.sh in ~/.zshtools/todo ${NOCOLOR}\n"
    mkdir -p ~/.zshtools/todo/bin
    wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.11.0/todo.txt_cli-2.11.0.tar.gz" -P ~/.zshtools/
    tar xvf ~/.zshtools/todo.txt_cli-2.11.0.tar.gz -C ~/.zshtools/todo --strip 1 && rm ~/.zshtools/todo.txt_cli-2.11.0.tar.gz
    ln -s ~/.zshtools/todo/todo.sh ~/.zshtools/todo/bin/todo.sh     # so only .../bin is included in $PATH
    ln -s ~/.zshtools/todo/todo.cfg ~/.todo.cfg     # it expects it there or ~/todo.cfg or ~/.todo/config
else
    printf "todo.sh is ${OK}already installed ${NOCOLOR}in ~/.zshtools/todo/bin/\n"
fi

if [[ $1 == "--cp-hist" ]] || [[ $1 == "-c" ]]; then
    printf "\nCopying bash_history to zsh_history\n"
    if command -v python &>/dev/null; then
        wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
        cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
    else
        if command -v python3 &>/dev/null; then
            wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
            cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
        else
            printf "${ERROR}Python is not installed, can't copy bash_history to zsh_history ${NOCOLOR}\n"
        fi
    fi
else
    printf "\n${ERROR}Not copying bash_history to zsh_history, as --cp-hist or -c is not supplied ${NOCOLOR}\n"
fi


# source ~/.zshrc
printf "\n${INFO}Sudo access is needed to change default shell ${NOCOLOR}\n"
printf "\n${INFO}Making ZSH the default shell ${NOCOLOR}\n"
sudo sh -c "echo $(which zsh) >> /etc/shells"

if chsh -s $(which zsh); then
    printf "${OK}Installation Successful, ${NOCOLOR}exit terminal and enter a new session"
else
    printf "${ERROR}Something is wrong. ${NOCOLOR} Please try again"
fi
exit

p10k configure