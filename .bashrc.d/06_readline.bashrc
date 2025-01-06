# Autocompletion settings
set completion-ignore-case on          # Ignore case during completion
set show-all-if-ambiguous on           # Show all matches if ambiguous
set mark-symlinked-directories on      # Mark symlinked directories
set page-completions off               # Disable paging for completions
set visible-stats on                   # Show stats for files (like size, permissions)
set colored-completion-prefix on       # Highlight matching prefix in color
set colored-stats on                   # Colorize stats
set skip-completed-text on             # Skip text that's already completed
set input-meta on                      # Allow 8-bit input
set output-meta on                     # Display 8-bit characters correctly
set convert-meta off                   # Disable conversion of 8th bit to meta prefix

# Key bindings
#bind '"\e[A": history-search-backward' # Search history for commands starting with current input
#bind '"\e[B": history-search-forward'  # Same as above but forward
bind '"\e[Z": menu-complete'           # Shift+Tab for menu completion
bind '"\e[3;3~": kill-word'            # Alt+Delete to delete the previous word
