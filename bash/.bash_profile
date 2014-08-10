### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


### Added for node.js and npm
export PATH="/usr/local/bin:$PATH"


### Added for Android SDK adb
export PATH="~/Development/Mobile/Android/sdk/platform-tools:$PATH"

### Added for Android SDK Tools
export PATH="~/Development/Mobile/Android/sdk/tools:$PATH"


### Enable colors in terminal
export CLICOLOR=1

### Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 


### Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

### Alias section
alias "ll=ls -la"

### Alias section
alias "adb-unlock=adb kill-server && adb start-server && adb devices"

### Alias section
alias "showFiles=defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias "hideFiles=defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"