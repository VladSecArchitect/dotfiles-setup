# Homebrew setup

# Detect Homebrew installation path (Intel or ARM)
if [[ -x "/usr/local/bin/brew" ]]; then
    export BREW_HOME="/usr/local"
elif [[ -x "/opt/homebrew/bin/brew" ]]; then
    export BREW_HOME="/opt/homebrew"
else
    # Homebrew not found; exit script
    echo "Homebrew not found. Skipping Homebrew setup." >&2
    return
fi

# Define full path to the brew executable
export BREW_BIN="${BREW_HOME}/bin/brew"

# Load Homebrew environment variables
if [[ -x "${BREW_BIN}" ]]; then
    # Add Homebrew environment to the shell
    eval "$(${BREW_BIN} shellenv)"

    # Enable bash-completion if installed
    local bash_completion="$(${BREW_BIN} --prefix)/etc/profile.d/bash_completion.sh"
    if [[ -r "$bash_completion" ]]; then
        source "$bash_completion"
        echo "Bash-completion loaded from $bash_completion"
    else
        echo "Bash-completion not found in Homebrew." >&2
    fi
else
    echo "Brew executable not found at ${BREW_BIN}. Skipping." >&2
fi
