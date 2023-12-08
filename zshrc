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

plugins=(alister command-not-found common-aliases docker git git-extras github ssh-agent symfony symfony2 systemadmin tmux wd zsh-syntax-highlighting)
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent id_rsa.201702
# a10y_rsa id_rsa2 id_github topbit.id_rsa id_rsa

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

# not using Ruby much, if any
## for Homebrew installed rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
#@todo add rvm?
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# problematical with .env files that usually read from a file
# echo 'source ~/.autoenv/activate.sh'

# From https://github.com/sharkdp/bat#integration-with-other-tools
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# It might also be necessary to set MANROFFOPT="-c" if you experience formatting problems.

# From https://github.com/sharkdp/bat#integration-with-other-tools
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
