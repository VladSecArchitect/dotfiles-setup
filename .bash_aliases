#   -----------------------------
#   1.  TERMINAL NAVIGATION
#   -----------------------------

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
#alias .='echo $PWD'                        # breaks the . (source) builtin — bash_completion and any `. file` call echo PWD instead of sourcing
alias ....="cd ../../.."                    # ....   Go back 3 levels (dot notation)
alias .....="cd ../../../.."                # .....  Go back 4 levels (dot notation)
alias -- -="cd -"                           # -:     Go to previous directory (short form)
alias dl="cd ~/Downloads"                   # dl:    Go to Downloads
#alias d="cd ~/Desktop"                     # conflicts with d='docker'
alias ~="cd ~"                              # ~:     Go Home
alias home='cd ~'                           # home:  Go to home directory
alias back='cd -'                           # back:  Go to previous directory
alias c='clear'                             # c:     Clear terminal display
#alias cl="clear"                           # conflicts with cl="fc -e -|pbcopy" (copy last output)
#alias c="tr -d '\n' | pbcopy"              # conflicts with c='clear'


#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias ls='ls -FAGhp'
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias la="ls -aF"
alias ld="ls -ld"
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'
alias l='ls -CF --color=auto'               # l:     Compact file list with indicators
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias grep='grep -n'
alias grep2='grep'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
command -v hd > /dev/null || alias hd="hexdump -C"
alias edit='subl'                           # edit:  Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:     Opens current directory in MacOS Finder
alias which='type -all'                     # which: Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:  Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='bind "set completion-ignore-case on"'  # cic:   Make tab-completion case-insensitive
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:    Pipe content to file on MacOS Desktop
alias h='history'
alias his-20='history | tail -20'
alias he="history -a"                       # he:    Export history (share between sessions)
alias hi="history -n"                       # hi:    Import history (share between sessions)
alias hgrep="history | grep"                # hgrep: Search history for a keyword
alias machoview="open -a machoview"

#   lr:  Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles: Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # Creates a file of 10mb size (all zeros)
alias ax="chmod a+x"                        # ax:    Make file executable


#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

alias qfind="find . -name"                  # qfind: Quickly search for file
alias todos="grep -rn 'TODO\|FIXME\|HACK' ."  # todos: List TODO/FIX lines in current project


#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias topForever='top -l 9999999 -s 10 -o cpu'
alias ttop="top -R -F -s 10 -o rsize"
alias cpu='top -o cpu'
alias mem='top -o rsize'
#alias top="sudo htop"                      # overrides system top; install htop and invoke directly
#alias meminfo='free -m -l -t'             # Linux only (free not available on macOS)


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias ping='ping -c 5'
alias ports='sudo lsof -i -P | grep LISTEN'             # All listening ports
alias myip='curl -s ifconfig.me'                        # Public facing IP Address
alias ip4='curl -s -4 ifconfig.me'                      # Public IPv4
alias ip6='curl -s -6 ifconfig.me'                      # Public IPv6
alias myip-full='curl -s ipinfo.io | python3 -m json.tool'  # Full IP info with geo
alias localip='ipconfig getifaddr en0'                  # Local IP on primary interface
alias ip="curl --disable ifconfig.me/ip"                # ip:    Public IP (plain)
alias ipf="curl --disable ipinfo.io"                    # ipf:   Detailed IP info (JSON)
alias netcheck="ping -c 3 8.8.8.8"                     # netcheck: Quick connectivity test
alias netCons='lsof -i'                                 # Show all open TCP/IP sockets
alias flushDNS='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias lsock='sudo /usr/sbin/lsof -i -P'                 # Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'       # Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'       # Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'                   # Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'                   # Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'             # All listening connections
alias showBlocked='sudo pfctl -sr'                       # Show PF firewall rules (ipfw removed in macOS 10.10)
alias netstat_osx="sudo lsof -i -P"
#alias portt='netstat -tulanp'              # Linux only (netstat flags differ on macOS)
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'
alias purge='sudo purge'
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; qlmanage -r cache 2>/dev/null"
alias showhidden='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
alias stfu="osascript -e 'set volume output muted true'"
alias tmlog="log show --predicate 'subsystem == \"com.apple.TimeMachine\"' --last 30m | tail -20"
alias mountall='system_profiler SPFireWireDataType | grep "BSD Name: disk.$" | sed "s/^.*: //" | (while read i; do /usr/sbin/diskutil mountDisk $i; done)'
alias unmountall='system_profiler SPFireWireDataType | grep "BSD Name: disk.$" | sed "s/^.*: //" | (while read i; do /usr/sbin/diskutil unmountDisk $i; done)'
alias df='df -h'
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias reload="exec $SHELL -l"
alias sudo='sudo '
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"
alias plistbuddy="/usr/libexec/PlistBuddy"
alias week='date +%V'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias map="xargs -n1"
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
alias wrapoff='tput rmam'
alias wrapon='tput smam'


#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'
alias apacheRestart='sudo apachectl graceful'
alias apachet='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'
alias apacher='sudo apachectl restart'
alias editHosts='sudo edit /etc/hosts'
alias herr='tail /var/log/apache2/error_log'
alias apacheLogs="less +F /var/log/apache2/error_log"


#   ---------------------------------------
#   9.  GIT
#   ---------------------------------------

alias gs='git status'
alias gst='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gpl='git pull'
alias gp='git push'
alias gps='git push'
alias gl='git log --oneline --graph --decorate -20'
#alias gl='git pull'                        # conflicts with gl='git log...' (above)
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gaa='git add .'
alias gss='git status -s'
alias gdd='git diff --cached'
alias gdw='git diff --color-words'
alias gdt='git difftool'
alias gca='git commit -v -a'
alias gup='git fetch && git rebase'
alias gpo='git push origin'
alias gcp='git cherry-pick'
alias gcount='git shortlog -sn'
alias gdel='git branch -D'


#   ---------------------------------------
#   10.  DOCKER
#   ---------------------------------------

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dclean='docker system prune -f'
alias dlogs='docker logs -f'
alias dexec='docker exec -it'


#   ---------------------------------------
#   TMUX
#   ---------------------------------------

alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'


#   ---------------------------------------
#   11.  MISC
#   ---------------------------------------

alias chrome="open -a \"Google Chrome\""
alias safari="open -a \"Safari\""
alias bp="$EDITOR ~/.bash_profile"          # bp:    Edit .bash_profile
alias src="source ~/.bash_profile"          # src:   Reload bash config
alias cl="fc -e -|pbcopy"                   # cl:    Copy output of last command to clipboard
alias cpwd='pwd|tr -d "\n"|pbcopy'           # cpwd:  Copy the working directory path
alias pubkey='cat ~/.ssh/id_ed25519.pub | pbcopy && echo "SSH public key copied to clipboard"'
alias tn='tr -d "\n"'                        # tn:    Trim newlines
alias rmdbc="find . -name '*conflicted*' -exec rm {} \;"  # Remove Dropbox conflicted files
alias brewup='brew update && brew upgrade && brew cleanup && brew doctor'
alias trimcopy="tr -d '\n' | pbcopy"
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"


#   ---------------------------------------
#   12.  APPSEC / SECURITY
#   ---------------------------------------

# Base64 encode / decode
alias b64e='base64'
alias b64d='base64 -d'

# ROT13
alias rot13='tr "A-Za-z" "N-ZA-Mn-za-m"'

# Hash files
alias sha256file='shasum -a 256'
alias sha1file='shasum -a 1'

# Security headers audit (response headers only)
alias headers='curl -sI'

# Active listening ports (cleaner than lsof -i)
alias listen='sudo lsof -iTCP -sTCP:LISTEN -P -n'
#alias listen="lsof -P -i -n"              # conflicts with listen (above)

# Established connections grouped by process
alias connections='sudo lsof -i -P -n | grep ESTABLISHED'

# Sniff unencrypted HTTP on Wi-Fi interface
alias sniff='sudo tcpdump -i en0 -A -s0 "port 80"'

# DNS — all record types for a domain
alias digall='dig +nocmd any +multiline +noall +answer'

# whois with less noise
alias wh='whois'

# ARP table (find hosts on local network)
alias arpt='arp -a'

# macOS security
alias sip_status='csrutil status'
alias gatekeeper='spctl --status'
alias keychain_list='security dump-keychain | grep "\"acct\""'

# Docker security — find containers with --privileged or host network
alias docker_priv='docker ps -q | xargs docker inspect --format "{{.Name}} privileged={{.HostConfig.Privileged}} net={{.HostConfig.NetworkMode}}"'

# Password / Token generation
alias generate_password='openssl rand -base64 16 | tr -dc "a-zA-Z0-9!@#$%^&*()-_+=" | fold -w 16 | head -n 1'
alias generate_human_password='openssl rand -base64 16 | tr -dc "a-zA-Z0-9" | fold -w 16 | head -n 1'
alias uuid='python3 -c "import uuid; print(uuid.uuid4())"'

# Android RE
alias dex2jar='sh /usr/local/bin/dex2jar/d2j-dex2jar.sh'

# Dump cleartext HTTP traffic (host + URL)
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Mirror a website for offline analysis
alias websiteget="wget --random-wait -r -p -e robots=off -U mozilla"


#   ---------------------------------------
#   13.  MISC / TOOLS
#   ---------------------------------------

alias tp='touch todo.taskpaper && open -a "Taskpaper" todo.taskpaper'

# zoxide — smarter cd, replaces unmaintained fasd
command -v zoxide &>/dev/null && eval "$(zoxide init bash)" && alias zi='z'
