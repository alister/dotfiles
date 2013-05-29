c() { cd ~/repo/$1; }
_c() { _files -W ~/repo -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

### autocorrect is more annoying than helpful
##unsetopt correct_all

# a few aliases I like
alias st='git status'
alias gd='git diff'
#alias tlog='tail -f log/development.log'

# add plugin's bin directory to path
export PATH="$(dirname $0)/bin:$PATH"
