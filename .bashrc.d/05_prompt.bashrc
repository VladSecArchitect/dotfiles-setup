# Prompt customization
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"

# Colors
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]]; then
        orange=$(tput setaf 166)
        yellow=$(tput setaf 136)
        green=$(tput setaf 64)
        violet=$(tput setaf 61)
        white=$(tput setaf 15)
    else
        orange="\033[1;33m"
        yellow="\033[1;33m"
        green="\033[1;32m"
        violet="\033[1;35m"
        white="\033[1;37m"
    fi
    reset=$(tput sgr0)
else
    orange="\033[1;33m"
    yellow="\033[1;33m"
    green="\033[1;32m"
    violet="\033[1;35m"
    white="\033[1;37m"
    reset="\033[m"
fi

# PS1 and PS2 setup
export PS1=$'\\[\\033]0;\\W\\007\\]\\[\E[1m\\]\\n\\[\E[38;5;166m\\]\\u\\[\E[97m\\]@\\[\E[38;5;136m\\]\\h\\[\E[97m\\]: \\[\E[38;5;64m\\]\\w$(prompt_git)\\[\E(B\E[m\\]\\n[\\[\\e[31m\\]\\!\\[\\e[0m\\]]\\[\E[97m\\]$ \\[\E(B\E[m\\]'
export PS2=$'\\[\E[38;5;136m\\]→ \\[\E(B\E[m\\]'


# Define a colorful prompt with Git branch
#PS1='\[\033[1;32m\]\u@\h:\[\033[1;34m\]\w\[\033[0;33m\]$(prompt_git)\[\033[0m\]\n$ '
#PS2='> '
