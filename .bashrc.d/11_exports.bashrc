# Set default editor based on operating system
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS: Use Sublime Text
    if command -v subl &>/dev/null; then
        export EDITOR="subl -n -w"    # -n opens a new window, -w waits for the file to close
        export VISUAL="subl -n -w"
    else
        # Fallback to nano if Sublime Text is not installed
        export EDITOR="nano"
        export VISUAL="nano"
    fi
else
    # Other systems: Use nano by default. For Crontab, Git etc.
    export EDITOR="nano"
    export VISUAL="nano"
fi