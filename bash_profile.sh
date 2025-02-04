# Configuring Our Prompt
# ======================

  # if you install git via homebrew, or install the bash autocompletion via homebrew, you get __git_ps1 which you can use in the PS1
  # to display the git branch.  it's supposedly a bit faster and cleaner than manually parsing through sed. i dont' know if you care
  # enough to change it

  # Use git-completion.bash
  if [ -f ~/.git-completion.bash ]; then
        . ~/.git-completion.bash
  fi

  # This function is called in your prompt to output your active git branch.
  function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {

    function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }

    # Define some local colors
    local         RED="\[\033[0;31m\]" # This syntax is some weird bash color thing I never
    local   LIGHT_RED="\[\033[1;31m\]" # really understood
    local        CHAR="♥"
    # ♥ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\[\e]2;\u@\h\a[\[\e[37;44;1m\]\t\[\e[0m\]]$RED\$(parse_git_branch) \[\e[32m\]\W\[\e[0m\]\n\[\e[0;31m\]$CHAR \[\e[0m\]"
      PS2='> '
      PS4='+ '
    }

  # Finally call the function and our prompt is all pretty
  prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.

# Environment Variables
# =====================
  # Library Paths
  # These variables tell your shell where they can find certain
  # required libraries so other programs can reliably call the variable name
  # instead of a hardcoded path.

    # NODE_PATH
    # Node Path from Homebrew I believe
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

    # Those NODE & Python Paths won't break anything even if you
    # don't have NODE or Python installed. Eventually you will and
    # then you don't have to update your bash_profile

  # Configurations

    # GIT_MERGE_AUTO_EDIT
    # This variable configures git to not require a message when you merge.
    export GIT_MERGE_AUTOEDIT='no'

    # Editors
    # Tells your shell that when a program requires various editors, use vim.
    # The -w flag tells your shell to wait until sublime exits
    export VISUAL="vim"
    export SVN_EDITOR="vim"
    export GIT_EDITOR="vim"
    export EDITOR="vim"

  # Paths

    # The USR_PATHS variable will just store all relevant /usr paths for easier usage
    # Each path is seperate via a : and we always use absolute paths.

    # A bit about the /usr directory
    # The /usr directory is a convention from linux that creates a common place to put
    # files and executables that the entire system needs access too. It tries to be user
    # independent, so whichever user is logged in should have permissions to the /usr directory.
    # We call that /usr/local. Within /usr/local, there is a bin directory for actually
    # storing the binaries (programs) that our system would want.
    # Also, Homebrew adopts this convetion so things installed via Homebrew
    # get symlinked into /usr/local
    export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"

    # Hint: You can interpolate a variable into a string by using the $VARIABLE notation as below.

    # We build our final PATH by combining the variables defined above
    # along with any previous values in the PATH variable.

    # Our PATH variable is special and very important. Whenever we type a command into our shell,
    # it will try to find that command within a directory that is defined in our PATH.
    # Read http://blog.seldomatt.com/blog/2012/10/08/bash-and-the-one-true-path/ for more on that.
    export PATH="$USR_PATHS:$PATH"

    # If you go into your shell and type: $PATH you will see the output of your current path.
    # For example, mine is:
    # /Users/avi/.rvm/gems/ruby-1.9.3-p392/bin:/Users/avi/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/avi/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/avi/.rvm/bin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/local/mysql/bin:/usr/local/share/python:/bin:/usr/sbin:/sbin:

# Helpful Functions
# =====================

# A function to CD into the desktop from anywhere
# so you just type desktop.
# HINT: It uses the built in USER variable to know your OS X username

# USE: desktop
#      desktop subfolder
function desktop {
  cd /Users/$USER/Desktop/$@
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Aliases
# =====================
  # LS
  alias l='ls -lah'

  # Git
  alias gst="git status"
  alias gl="git pull"
  alias gp="git push"
  alias gd="git diff | mate"
  alias gc="git commit -v"
  alias gca="git commit -v -a"
  alias gb="git branch"
  alias gba="git branch -a"
  alias gcam="git commit -am"
  alias gbb="git branch -b"


# Case-Insensitive Auto Completion
bind "set completion-ignore-case on"

# Final Configurations and Plugins
# =====================
  # Git Bash Completion
  # Will activate bash git completion if installed
  # via homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

# Alias to make mvim the default
#alias vim='mvim -v'
#alias vi='mvim -v'

export NVM_DIR="/Users/orr/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

nvm use 12
#nvm use 8.10.0
#nvm use 6.11.1

# Instead of using default VIM provided by Mac, use a newer version
# of VIM which has been isntalled in /opt/local.
#
#export PATH=/opt/local/bin:$PATH
#export PATH="$PATH:/Applications/Genymotion.app/Contents/MacOS/tools"

#export web=~/Desktop/Projects/web/
#export shared=~/Desktop/Projects/@haywheel/shared/
#export native=~/Desktop/Projects/haywheel-native/
#export mk=~/Desktop/Projects/marketplace/
#export ios=~/Desktop/Projects/iOS/
#export ts=~/Desktop/Development/table-structure
#export scythe=~/Desktop/Projects/scythe
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_SDK=/Users/orr/Library/Android/sdk
export PATH=~/Library/Android/sdk/platform-tools:$PATH
export g=~/dev/munched/graphql
export n=~/dev/munched/native
export a1=~/dev/munched/api
export x=~/Dropbox
export xp=~/Dropbox/Plater
export p=~/dev/plater
export w1=~/dev/munched/web
export s1=~/dev/munched/scraper
export l=~/dev/munched/landing-page
export pw=/Users/orr/dev/plater-web-app
export ea=/Users/orr/dev/munched/extension-api
export k=$p/packages
export f=$k/firebase/functions
export u=$k/utils
export b=$k/browser-extension
export d=$k/dom-parser
export a=$k/api
export c=$k/constants
export w=$k/web
#export PATH=$PATH:$HOME/mongodb/bin
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Enable direnv to set directory specific environmental
# variables. See: https://direnv.net/
eval "$(direnv hook bash)"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Tell virtualenv to use python version 3.8 by default
export VIRTUALENVWRAPPER_PYTHON='/Library/Frameworks/Python.framework/Versions/3.8'

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
export PATH="/usr/local/mysql/bin:${PATH}"
#alias python="~/dev/munched/scraper-2/python-lang/bin/python"
#export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin
#alias pyton=/Library/Frameworks/Python.framework/Versions/3.8/bin/python3.8
#alias pip=/Library/Frameworks/Python.framework/Versions/3.8/bin/pip3.8

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
export PATH=/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH
#alias python=/Library/Frameworks/Python.framework/Versions/3.7/bin/python3.7

