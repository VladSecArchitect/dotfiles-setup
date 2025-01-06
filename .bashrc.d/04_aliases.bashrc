# Enhanced 'ls' command aliases for better file management
alias ls='ls -FAGhp'
alias ll='ls -alF --color=auto'         # Detailed list with colors
alias la='ls -A --color=auto'           # Show all except . and ..
alias l='ls -CF --color=auto'           # Compact file list
alias ld='ls -ld'                       # Detailed info about current directory
alias lt='ls -At1 && echo "------Oldest--"'  # List files by access time (oldest at the bottom)
alias ltr='ls -Art1 && echo "------Newest--"' # List files by reverse access time (newest at the bottom)

# Navigation shortcuts (directory traversal)
alias cd..='cd ..'
alias ..='cd ..'                        # Go one level up
alias ...='cd ../..'                    # Go two levels up
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias home='cd ~'                       # Go to home directory
alias back='cd -'                       # Go to previous directory
alias ~='cd ~'

# Git shortcuts (git command aliases)
if command -v git >/dev/null 2>&1; then
    alias g="git"
    alias gl="git log"
    alias gs="git status"
    alias gst="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"
    alias gco="git checkout"
else
    echo "Git is not installed. Skipping Git aliases."
fi


# Utility aliases (general utilities)
alias cls="clear && printf '\033[3J'"   # Clear screen and scrollback
alias c='clear'
alias cpwd='pwd | tr -d "\n" | pbcopy' # Copy current directory to clipboard
alias cl="fc -e -|pbcopy"              # Copy last command output to clipboard

alias cpu='top -o cpu'                 # Show CPU usage
alias mem='top -o rsize'               # Show memory usage


# Generates a password with 12 alphanumeric characters for easier readability.
# Includes uppercase, lowercase, and digits only.
alias generate_human_password='openssl rand -base64 16 | tr -dc "a-zA-Z0-9" | fold -w 16 | head -n 1'
# Usage: generate_human_password
alias generate_password='openssl rand -base64 16 | tr -dc "a-zA-Z0-9!@#$%^&*()-_+=" | fold -w 16 | head -n 1'



# Networking-related aliases
alias ip="curl --disable ifconfig.me/ip"    # Get public IP address using ifconfig.me
alias ipf="curl --disable ipinfo.io"        # Get detailed IP info using ipinfo.io
alias netcheck="ping -c 3 8.8.8.8"          # Check network connectivity by pinging Google DNS
alias netCons='lsof -i'                     # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/sbin/lsof -i -P'      # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP' # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP' # lsockT:       Display only open TCP sockets
alias openPorts='sudo lsof -i | grep LISTEN' # openPorts:    All listening connections



# Conditional aliases and functions for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Finder aliases (macOS Finder interactions)
    alias f='open -a Finder ./'

    # System operations (macOS-specific tasks)
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"  # Remove .DS_Store files
    alias stfu="osascript -e 'set volume output muted true'"         # Mute system volume
    alias tmlog="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1" # Show Time Machine logs

    # Networking (network-related commands)
	alias flushDNS='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'  # Full DNS cache flush

    # Homebrew aliases (macOS package manager)
    alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
fi
