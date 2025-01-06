### Utility Functions ###

# Clear terminal and scrollback buffer
function cls {
    clear && printf '\033[3J'
    # 'clear': Clears the terminal screen.
    # '\033[3J': Clears the terminal's scrollback buffer.
    #osascript -e 'tell application "System Events" to keystroke "k" using command down'
}

# Reload bash configuration
function reload_bashrc {
    source ~/.bashrc
    echo "Reloaded .bashrc"
    # 'source ~/.bashrc': Reloads the current shell configuration.
}

# Determine size of a file or total size of a directory
# Displays the size of files or directories in human-readable format.
fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi

    echo "Directory contents (including hidden files):"
    while IFS= read -r line; do
        size=$(echo "$line" | awk '{print $1}')
        path=$(echo "$line" | awk '{print $2}')

        if [ -d "$path" ]; then
            printf "%s\t%s/\n" "$size" "$path" # Append '/' for directories
        else
            printf "%s\t%s\n" "$size" "$path"
        fi
    done < <(du $arg .[^.]* ./* 2>/dev/null | sort -h)

    echo
    echo "Total size:"
    du -sh . | awk '{print $1}'
}


# Start an HTTP server from a directory, optionally specifying the port
# Serves the current directory over HTTP. Defaults to port 8000.
server() {
    local port="${1:-8000}"
    python3 -m http.server "$port" &
    echo "Server running at http://localhost:${port}/"
}


# Run `dig` and display the most useful info
# Simplifies DNS lookups by showing key information only.
digga() {
    if [ -z "$1" ]; then
        echo "Usage: digga <domain>"
        return 1
    fi

    if ! command -v dig &> /dev/null; then
        echo "Error: 'dig' command not found. Please install it first."
        return 1
    fi

    dig +nocmd "$1" any +multiline +noall +answer
}


# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
# Enhanced directory listing with colors, hidden files, and a user-friendly pager.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

# Search within manpages for a term and display results with context
mans() {
    man "$1" | grep -iC2 --color=always "$2" | less
}

### Unicode Utilities ###

# UTF-8-encode a string of Unicode symbols
escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    # Prints a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo "" # newline
    fi
}
# Converts a string of Unicode symbols into UTF-8-encoded escape sequences.

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    # Prints a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo "" # newline
    fi
}
# Decodes Unicode escape sequences (e.g., \x{ABCD}) into human-readable text.

# Get a character’s Unicode code point
codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    # Prints a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo "" # newline
    fi
}
# Returns the Unicode code point of a given character in the format U+XXXX.


### Git Integration ###

# Display the current Git branch in the prompt
prompt_git() {
    local branchName=""
    # Check if the current directory is inside a Git repository.
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the current branch name or commit hash (if detached HEAD).
        branchName=$(git symbolic-ref --quiet --short HEAD || git rev-parse --short HEAD)
        # Customize prompt with branch name (adjust colors as needed).
        echo -e "${white} on ${violet}${branchName}${reset}"
    fi
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@";
    }
fi;

### Custom Helper Functions ###

# Create a directory and navigate into it
mcd() {
    mkdir -p "$1" && cd "$1"
    # 'mkdir -p': Creates the directory if it doesn't already exist.
    # 'cd': Navigates into the newly created directory.
}

# Check if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then

    # Move files to macOS Trash
    trash() {
        command mv "$@" ~/.Trash
        # Moves specified files or directories to the macOS Trash.
        # '@': Allows for multiple files to be passed as arguments.
    }

    # Preview file(s) with macOS QuickLook
    ql() {
        qlmanage -p "$*" >& /dev/null
        # 'qlmanage -p': Opens macOS QuickLook preview for specified files.
        # '>/dev/null': Suppresses output in the terminal.
    }

    ### File and Directory Opening Shortcuts (macOS only) ###

    # `s` with no arguments opens the current directory in Sublime Text, otherwise opens the given location
    # Shortcut for opening files or directories in Sublime Text.
    function s() {
        if [ $# -eq 0 ]; then
            subl .
        else
            subl "$@"
        fi
    }

    # `o` with no arguments opens the current directory, otherwise opens the given location
    # Shortcut for opening files or directories with the default system application.
    function o() {
        if [ $# -eq 0 ]; then
            open .
        else
            open "$@"
        fi
    }

fi

# `v` with no arguments opens the current directory in Vim, otherwise opens the given location
# Shortcut for opening files or directories in Vim. Works on all platforms.
function v() {
    if [ $# -eq 0 ]; then
        vim .
    else
        vim "$@"
    fi
}


# Show all the names (CNs and SANs) listed in the SSL certificate for a domain
# Retrieves and displays Common Name (CN) and Subject Alternative Names (SANs) for an SSL certificate.
getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified."
        return 1
    fi

    local domain="${1}"
    echo "Testing ${domain}…"
    echo # Newline for readability

    # Retrieve the certificate
    local cert=$(echo -n | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>/dev/null | openssl x509 -noout -text)

    if [[ -z "${cert}" ]]; then
        echo "ERROR: Unable to retrieve certificate for ${domain}."
        return 1
    fi

    # Parse certificate data
    echo "Common Name (CN):"
    echo "${cert}" | grep "Subject:" | sed -n 's/^.*CN=//p' || echo "None found"
    echo
    echo "Subject Alternative Names (SANs):"
    echo "${cert}" | awk '/X509v3 Subject Alternative Name:/ {getline; print}' | sed -E 's/DNS://g;s/,/\n/g' || echo "None found"
}


### File and Archive Management ###

# Create a data URL from a file
# Converts a file to a base64-encoded data URL for embedding in HTML or CSS.
function dataurl() {
    if [ -z "$1" ]; then
        echo "Usage: dataurl <file>"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: File '$1' does not exist."
        return 1
    fi

    local mimeType
    mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}


# Create a ZIP archive of a folder
zipf() {
    zip -r "$1".zip "$1"
    # 'zip -r': Recursively creates a ZIP archive for the specified folder.
    # Adds '.zip' extension to the archive name automatically.
}


# Extract various archive types
extract() {
    if [ -f "$1" ]; then
        # Check if the argument is a valid file.
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;; # Extract .tar.bz2 files
            *.tar.gz)    tar xzf "$1"     ;; # Extract .tar.gz files
            *.bz2)       bunzip2 "$1"     ;; # Decompress .bz2 files
            *.rar)       unrar e "$1"     ;; # Extract .rar files
            *.gz)        gunzip "$1"      ;; # Decompress .gz files
            *.tar)       tar xf "$1"      ;; # Extract .tar files
            *.tbz2)      tar xjf "$1"     ;; # Extract .tbz2 files
            *.tgz)       tar xzf "$1"     ;; # Extract .tgz files
            *.zip)       unzip "$1"       ;; # Extract .zip files
            *.Z)         uncompress "$1"  ;; # Decompress .Z files
            *.7z)        7z x "$1"        ;; # Extract .7z files
            *)           echo "'$1' cannot be extracted via extract()" ;;
            # Unsupported file type.
        esac
    else
        echo "'$1' is not a valid file"
        # Notify if the input is not a file.
    fi
}

# Compare original and gzipped file size
# Calculates and displays the size reduction achieved by gzipping a file.
gz() {
    if ! command -v gzip &>/dev/null; then
        echo "Error: 'gzip' is required but not installed." >&2
        return 1
    fi

    local origsize=$(wc -c < "$1");
    local gzipsize=$(gzip -c "$1" | wc -c);
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
    printf "Original: %d bytes\n" "$origsize";
    printf "Gzipped: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}


# Compresses and encrypts a folder or file into a password-protected tar archive.
# Usage: tar_protect <folder_or_file> <output_archive.tar.enc>
tar_protect() {
    if command -v pbpaste &> /dev/null; then
        password=$(pbpaste)
    else
        read -sp "Enter password: " password
        echo
    fi

    if [[ $# -lt 2 ]]; then
        echo "Usage: tar_protect <folder_or_file> <output_archive.tar.enc>"
        return 1
    fi

    tar -cf - "$1" | openssl enc -aes-256-cbc -e -out "$2" -pass pass:"$password"
    unset password
}

# Creates a zip archive protected with a password.
# Usage: zip_protect <file> <output_archive.zip>
zip_protect() {
    if command -v pbpaste &> /dev/null; then
        password=$(pbpaste)
    else
        read -sp "Enter password: " password
        echo
    fi

    if [[ $# -lt 2 ]]; then
        echo "Usage: zip_protect <file> <output_archive.zip>"
        return 1
    fi

    zip -P "$password" "$2" "$1"
    unset password
}

# Encrypts a file using AES-256-CBC and a password from the clipboard or interactive input.
# Usage: encrypt_file <input_file> <output_encrypted_file>
encrypt_file() {
    if command -v pbpaste &> /dev/null; then
        password=$(pbpaste)
    else
        read -sp "Enter password: " password
        echo
    fi

    if [[ $# -lt 2 ]]; then
        echo "Usage: encrypt_file <input_file> <output_encrypted_file>"
        return 1
    fi

    openssl enc -aes-256-cbc -e -in "$1" -out "$2" -pass pass:"$password"
    unset password
}

# Decrypts a file encrypted with AES-256-CBC using a password from the clipboard or interactive input.
# Usage: decrypt_file <encrypted_file> <output_file>
decrypt_file() {
    if command -v pbpaste &> /dev/null; then
        password=$(pbpaste)
    else
        read -sp "Enter password: " password
        echo
    fi

    if [[ $# -lt 2 ]]; then
        echo "Usage: decrypt_file <encrypted_file> <output_file>"
        return 1
    fi

    openssl enc -aes-256-cbc -d -in "$1" -out "$2" -pass pass:"$password"
    unset password
}
