# Load custom scripts from ~/.bashrc.d
if [ -d ~/.bashrc.d ]; then
    for file in ~/.bashrc.d/*.{sh,bashrc}; do
        # Check if the file exists and is not a directory
        if [ -f "$file" ]; then
            # Source the file to load its content into the current shell
            . "$file"
        fi
    done
fi


eval "$(dircolors ~/.dircolors)"

# Reload .bashrc
alias reload="source ~/.bashrc && echo 'Reloaded .bashrc'"
