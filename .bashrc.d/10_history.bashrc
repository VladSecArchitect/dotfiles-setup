# Avoid duplicate lines and lines starting with space in history
HISTCONTROL=ignoreboth

# Set history length
HISTSIZE=100000
HISTFILESIZE=200000

# Automatically append and reload history after each command
export PROMPT_COMMAND="history -a; history -c; history -r"

# Ignore specific commands from history
export HISTIGNORE="&:ls:[bf]g:exit:clear"

# Verify the command from history before execution
shopt -s histverify

# Aliases for history management
alias he="history -a"       # Export history
alias hi="history -n"       # Import history
alias h="history"           # View history
alias his-20="history | tail -20"  # View last 20 commands
alias mem="history | grep"  # Search history for a keyword
