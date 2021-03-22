c() { cd ~/repo/$1; }
_c() { _files -W ~/repo -/; }
compdef _c c

#h() { cd ~/$1; }
#_h() { _files -W ~/ -/; }
#compdef _h h

### autocorrect is more annoying than helpful
##unsetopt correct_all

# a few aliases I like
alias st='git status'
alias gd='git diff'
#alias tlog='tail -f log/development.log'

# For working in Docker-compose 
alias dcecon='docker-compose exec php bin/console '
alias dcecom='docker-compose exec php composer '


# from https://github.com/denysdovhan/dotfiles/
# https://github.com/denysdovhan/dotfiles/blob/3d860e9c59f03d408463b3fba33c73397a9037f3/zsh/aliases.zsh
alias myip="curl -s https://4.ifcfg.me/"

# add plugin's bin directory to path
export PATH="$(dirname $0)/bin:$PATH"
export PS1="\w$ "
export EDITOR="joe"

# http://spf13.com/post/human-readable-du-sorted-by-size
#function duf {
#    du -k "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
#}

# http://fahdshariff.blogspot.co.uk/2011/04/add-colour-to-ant-output.html
# Add Colour to Ant Output
# You can add pretty colours to your ant output really easily by simply setting the following in your profile:
export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'

alias phpqa='docker run --init -it --rm -v $(pwd):/project -v $(pwd)/tmp-phpqa:/tmp -w /project alisterbulman/ci-php:php7.3'
