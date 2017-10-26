# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="bullet-train"
# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="refined"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(adb battery brew colored-man-pages colorize docker docker-compose forklift git meteor node npm nvm osx rsync sublime sudo zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

### Added for Android SDK adb
export PATH=$HOME/Development/Frameworks/Android/sdk/platform-tools:$PATH

### Added for Android SDK Tools
export PATH=$HOME/Development/Frameworks/Android/sdk/tools:$PATH

### Added for PHP 7.1
export PATH=/usr/local/php5/bin:$PATH

### Added for PHP Composer
export PATH=$HOME/.composer/vendor/bin:$PATH

# Node Version Manager
#export NVM_DIR="/Volumes/Data/Home/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


### Adding an alias to Development folder
alias dev="cd ~/Development/Git\ Repositories/"
alias devw="cd ~/Development/Git\ Repositories/Web/projects/"
alias devm="cd ~/Development/Git\ Repositories/Mobile"

### Docker
# Kill all running containers.
alias dkill='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dclean='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


alias ufwks="echo 'Updating brew...' && brew update && echo 'Updating node...' && sudo n latest && echo 'Updating npm...' && sudo npm update -g"