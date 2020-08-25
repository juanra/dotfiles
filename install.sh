#!/bin/bash

# Check if ZSH and dependencies are installed
echo -e "\e[34mHi there!, I will check if ZSH and its dependencies are installed..."
if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and its dependencies are \e[32malready installed\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "ZSH, WGET and GIT \e[32mInstalled\n"
    else
        echo -e "\e[31mPlease manually install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi

# Backup original .zshrc file
if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "\e[32mBacked up \e[39mthe current .zshrc to .zshrc-backup-date\n"
fi


echo -e "Installing oh-my-zsh\n"
if [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
else
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

cp -f .zshrc ~/

# Installing Oh My Zsh plugins

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ]; then
    cd ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/plugins/fast-syntax-highlighting
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

# Activating Oh My Zsh plugins
THEME_TO_ACTIVATE="powerlevel10k/powerlevel10k"
PLUGINS_TO_ACTIVATE_MAC="adb battery brew colored-man-pages colorize docker docker-compose fast-syntax-highlighting forklift git meteor node npm nvm osx sublime sudo zsh-autosuggestions zsh-completions"
PLUGINS_TO_ACTIVATE_LINUX="colored-man-pages colorize docker docker-compose fast-syntax-highlighting git meteor node npm sudo ubuntu zsh-autosuggestions zsh-completions"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Linux
  sed -i -e "s/\(ZSH_THEME=\).*/\1\"$THEME_TO_ACTIVATE\"/" .zshrc
  sed -i -e "s/\(plugins=\).*/\1($PLUGINS_TO_ACTIVATE_LINUX)/" .zshrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  sed -i -e "s/\(ZSH_THEME=\).*/\1\"$THEME_TO_ACTIVATE\"/" .zshrc
  sed -i -e "s/\(plugins=\).*/\1($PLUGINS_TO_ACTIVATE_MAC)/" .zshrc
fi

# Installing Fonts
echo -e "Installing Nerd Fonts\n"
if brew tap homebrew/cask-fonts && brew cask install font-firacode-nerd-font; then
    echo -e "Fira Code Nerd Font \e[32mInstalled\n"
else
    echo -e "\e[34mPlease go to https://github.com/ryanoasis/nerd-fonts for information about installing Nerd Fonts \n"
fi

# Installing Oh My Zsh themes
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    cd ~/.oh-my-zsh/custom/themes/powerlevel10k && git pull
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Installing command line tools
mkdir -p ~/.zshtools       # external plugins, things, will be instlled in here

# Installing fzf (general-purpose command-line fuzzy finder)
if [ -d ~/.zshtools/fzf ]; then
    cd ~/.zshtools/fzf && git pull
    ~/.zshtools/fzf/install --all --key-bindings --completion --no-update-rc --64
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zshtools/fzf
    ~/.zshtools/fzf/install --all --key-bindings --completion --no-update-rc --64
fi

# Installing k (directory listings for zsh with git features)
if [ -d ~/.oh-my-zsh/custom/plugins/k ]; then
    cd ~/.oh-my-zsh/custom/plugins/k && git pull
else
    git clone --depth 1 https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
fi

# Installing marker (bookmark commands)
if [ -d ~/.zshtools/marker ]; then
    cd ~/.zshtools/marker && git pull
else
    git clone --depth 1 https://github.com/pindexis/marker ~/.zshtools/marker
fi

if ~/.zshtools/marker/install.py; then
    echo -e "Installed Marker\n"
else
    echo -e "\e[31mPError installing Marker. \e[39mPlease try to manually install the package and try again.\n" && exit
fi

# Installing EXA (modern replacement for the command-line program ls)
if command -v exa &> /dev/null; then
    echo -e "EXA is \e[32malready installed\n"
else
    if sudo pacman -S exa || sudo dnf install -y exa || brew install exa; then
        echo -e "EXA \e[32mInstalled\n"
    else
        echo -e "\e[31mPlease manually install the following packages first, then try again: exa \n" && exit
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
    echo -e "Installing todo.sh in ~/.zshtools/todo\n"
    mkdir -p ~/.zshtools/todo/bin
    wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.11.0/todo.txt_cli-2.11.0.tar.gz" -P ~/.zshtools/
    tar xvf ~/.zshtools/todo.txt_cli-2.11.0.tar.gz -C ~/.zshtools/todo --strip 1 && rm ~/.zshtools/todo.txt_cli-2.11.0.tar.gz
    ln -s ~/.zshtools/todo/todo.sh ~/.zshtools/todo/bin/todo.sh     # so only .../bin is included in $PATH
    ln -s ~/.zshtools/todo/todo.cfg ~/.todo.cfg     # it expects it there or ~/todo.cfg or ~/.todo/config
else
    echo -e "todo.sh is \e[32malready instlled in \e[39m~/.zshtools/todo/bin/\n"
fi

if [[ $1 == "--cp-hist" ]] || [[ $1 == "-c" ]]; then
    echo -e "\nCopying bash_history to zsh_history\n"
    if command -v python &>/dev/null; then
        wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
        cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
    else
        if command -v python3 &>/dev/null; then
            wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
            cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
        else
            echo "Python is not installed, can't copy bash_history to zsh_history\n"
        fi
    fi
else
    echo -e "\nNot copying bash_history to zsh_history, as --cp-hist or -c is not supplied\n"
fi


# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi
exit

p10k configure