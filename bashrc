
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$HOME/.rvm/gems/ruby-2.0.0-p643/bin:$PATH
rvm use 2.0.0

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

          # Adding wsl-open as a browser for Bash for Windows
          if [[ $(uname -r) =~ (m|M)icrosoft ]]; then
            if [[ -z $BROWSER ]]; then
              export BROWSER=wsl-open
            else
              export BROWSER=$BROWSER:wsl-open
            fi
          fi
          
