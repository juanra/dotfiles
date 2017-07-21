#!/bin/bash

# Colors setup
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi


printf "${BLUE}Hi there!, get ready to install and setup new super shell (ZSH).${NORMAL}\n"

# Set required packages
REQUIRED_PACKAGES="git zsh"

# Let's update our package repositories first
printf "${BLUE}First, let's update our package repositories...${NORMAL}\n"
#apt-get update

printf "${BLUE}Now, let's check if the required packages are already installed...${NORMAL}\n"
for PACKAGE_NAME in $REQUIRED_PACKAGES; do
  if [ dpkg -l $PACKAGE_NAME > /dev/null 2>&1 ]; then
    printf "${BLUE}Nope, $PACKAGE_NAME is not installed, so let's install it!${NORMAL}\n"
    sudo apt-get install -y $PACKAGE_NAME
  else
    printf "${BLUE}Yep, $PACKAGE_NAME is already installed.${NORMAL}\n"
  fi
done

printf "${BLUE}Time to check if 'Oh My ZSH!' is installed...${NORMAL}\n"
if [ ! -n "$ZSH" ]; then
 ZSH=~/.oh-my-zsh
fi

if [ -d "$ZSH" ]; then
 printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
 printf "You'll need to remove $ZSH if you want to re-install.\n"
else
  printf "${BLUE}Boo!, 'Oh My ZSH!' is not installed.  Let's do it right now...${NORMAL}\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

printf "${BLUE}Ok! we are almost ready, we just need to install some custom themes and plugins...${NORMAL}\n"
printf "${BLUE}Installing Powerlevel9k theme...${NORMAL}\n"
git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
printf "${BLUE}Installing Bullet Train theme...${NORMAL}\n"
git clone https://github.com/caiogondim/bullet-train.zsh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/bullet-train
printf "${BLUE}Installing Pure theme...${NORMAL}\n"
git clone https://github.com/sindresorhus/pure.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/pure
printf "${BLUE}Installing zsh-completions plugin...${NORMAL}\n"
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
printf "${BLUE}Installing zsh-syntax-highlighting plugin...${NORMAL}\n"
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
printf "${BLUE}Installing zsh-syntax-highlighting plugin...${NORMAL}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf "${BLUE}Awesome! the last thing to do is to activate our favorite theme and plugins...${NORMAL}\n"
THEME_TO_ACTIVATE="refined"
PLUGINS_TO_ACTIVATE_MAC="adb battery brew colored-man-pages colorize docker docker-compose forklift git meteor node npm nvm osx sublime sudo zsh-autosuggestions zsh-completions zsh-syntax-highlighting"
PLUGINS_TO_ACTIVATE_LINUX="colored-man-pages colorize docker docker-compose git meteor node npm sudo ubuntu zsh-autosuggestions zsh-completions zsh-syntax-highlighting"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Linux
  sed -i -e "s/\(ZSH_THEME=\).*/\1\"$THEME_TO_ACTIVATE\"/" .zshrc
  sed -i -e "s/\(plugins=\).*/\1($PLUGINS_TO_ACTIVATE_LINUX)/" .zshrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  sed -i -e "s/\(ZSH_THEME=\).*/\1\"$THEME_TO_ACTIVATE\"/" .zshrc
  sed -i -e "s/\(plugins=\).*/\1($PLUGINS_TO_ACTIVATE_MAC)/" .zshrc
fi
printf "${GREEN}...and you are up and ready! Installation completed.
