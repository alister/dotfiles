# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gentoo"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"

. ~/.zsh/config
#. ~/.zsh/aliases
#. ~/.zsh/completion

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(alister autoenv bundler capistrano command-not-found common-aliases docker gem git git-extras github golang rake-fast redis ruby rvm ssh-agent symfony2 systemadmin tmux wd )
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent id_rsa id_rsa2 id_github id_rsa.toptal.pub.

# Customize to your needs...
export PATH="/home/alister/bin:/home/alister/.bin:vendor/bin:/home/alister/.npm-global/bin:$PATH"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

export EDITOR='joe'
# http://blog.tersmitten.nl/how-to-enable-syntax-highlighting-in-less.html
#  -- warning, 'lesspipe' will interfere with source-highlight
# sudo apt-get install source-highlight
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

source $ZSH/oh-my-zsh.sh


# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

## for Homebrew installed rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#@todo add rvm?
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

echo 'source ~/.autoenv/activate.sh'
