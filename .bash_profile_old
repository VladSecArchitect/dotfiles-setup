export EDITOR='subl -w'

[[ -s ~/.bashrc ]] && source ~/.bashrc

alias ls='ls -FAGhp'
alias grep='grep -n'
alias grep2='grep'

alias less='less -NM'
alias his-20='history | tail -20'
alias netstat_osx="sudo lsof -i -P"
alias machoview="open -a machoview"
#alias clterm="/usr/bin/osascript -e 'tell application \"System Events\" to tell process \"Terminal\" to keystroke \"k\" using command do$

alias dex2jar='sh /usr/local/bin/dex2jar/d2j-dex2jar.sh'

export TERM=xterm-color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;13'

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export TERM="xterm-color"
#PS1='\[[\[\e[31m\]\!\[\e[0m\]]\033[0;33m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]\$ '
PS1='[\[\e[33m\]\u@\H \[\e[32m\]\w\[\e[0m\]]\n[\[\e[31m\]\!\[\e[0m\]] > '
export HISTCONTROL=erasedups
shopt -s histappend

function cls {
clear && printf '\e[3J'
#osascript -e 'tell application "System Events" to keystroke "k" using command down'
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
export PATH="/usr/local/opt/llvm/bin:$PATH"


export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export RBENV_ROOT=/usr/local/var/rbenv

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
