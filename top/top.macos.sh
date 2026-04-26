#!/usr/bin/env bash
# macOS top wrapper — macOS top(1) has no .toprc support.
# Usage: source this file or copy aliases to .bash_aliases.
#
# macOS top flags reference:
#   -o <key>   Sort by: cpu, rsize, vsize, rshrd, pid, command, uid, th, time
#   -s <n>     Update every N seconds (default 1)
#   -n <n>     Show N processes
#   -l <n>     Log N samples and exit (0 = run until Ctrl+C)
#   -F         Don't calculate stats on shared libraries
#   -R         Don't traverse shared library hierarchy
#   -i         Ignore idle processes

# Interactive keybindings (press while top is running):
#   o           Change sort column
#   r           Toggle ascending/descending sort
#   s           Change update interval
#   ?           Help

# Sort by CPU usage, show top 30 processes, update every 2s
alias topc='top -o cpu -n 30 -s 2'

# Sort by memory (resident size), show top 30
alias topm='top -o rsize -n 30 -s 2'

# Sort by PID
alias toppid='top -o pid -n 30'

# One-shot snapshot (10 samples, log mode — useful for scripting)
alias topsnap='top -l 1 -o cpu -n 20 -F -R'

# Watch a specific process by name
topwatch() {
    if [ -z "$1" ]; then
        echo "Usage: topwatch <process-name>"
        return 1
    fi
    top -s 2 $(pgrep -d ' -pid ' "$1" 2>/dev/null | sed 's/^/-pid /')
}
