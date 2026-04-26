# Nothing to see here, everything is in .bash_profile
# [ -n "$PS1" ] && source ~/.bash_profile;
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
# https://apple.stackexchange.com/questions/12993/why-doesnt-bashrc-run-automatically#comment13715_13019
# https://apple.stackexchange.com/questions/42537/why-must-i-source-bashrc-every-time-i-open-terminal-for-aliases-to-work
# https://blog.dghubble.io/post/.bashprofile-.profile-and-.bashrc-conventions/
# https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/
# https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile
#
# For BASH: Read down the appropriate column. Executes A, then B, then C, etc.
# The B1, B2, B3 means it executes only the first of those files found.  (A)
# or (B2) means it is normally sourced by (read by and included in) the
# primary file, in this case A or B2.
#
# +---------------------------------+-------+-----+------------+
# |                                 | Interactive | non-Inter. |
# +---------------------------------+-------+-----+------------+
# |                                 | login |    non-login     |
# +---------------------------------+-------+-----+------------+
# |                                 |       |     |            |
# |   ALL USERS:                    |       |     |            |
# +---------------------------------+-------+-----+------------+
# |BASH_ENV                         |       |     |     A      | not interactive or login
# |                                 |       |     |            |
# +---------------------------------+-------+-----+------------+
# |/etc/profile                     |   A   |     |            | set PATH & PS1, & call following:
# +---------------------------------+-------+-----+------------+
# |/etc/bash.bashrc                 |  (A)  |  A  |            | Better PS1 + command-not-found
# +---------------------------------+-------+-----+------------+
# |/etc/profile.d/bash_completion.sh|  (A)  |     |            |
# +---------------------------------+-------+-----+------------+
# |/etc/profile.d/vte-2.91.sh       |  (A)  |     |            | Virt. Terminal Emulator
# |/etc/profile.d/vte.sh            |  (A)  |     |            |
# +---------------------------------+-------+-----+------------+
# |                                 |       |     |            |
# |   A SPECIFIC USER:              |       |     |            |
# +---------------------------------+-------+-----+------------+
# |~/.bash_profile    (bash only)   |   B1  |     |            | (doesn't currently exist)
# +---------------------------------+-------+-----+------------+
# |~/.bash_login      (bash only)   |   B2  |     |            | (didn't exist) **
# +---------------------------------+-------+-----+------------+
# |~/.profile         (all shells)  |   B3  |     |            | (doesn't currently exist)
# +---------------------------------+-------+-----+------------+
# |~/.bashrc          (bash only)   |  (B2) |  B  |            | colorizes bash: su=red, other_users=green
# +---------------------------------+-------+-----+------------+
# |                                 |       |     |            |
# +---------------------------------+-------+-----+------------+
# |~/.bash_logout                   |    C  |     |            |
# +---------------------------------+-------+-----+------------+
#
# ** (sources ~/.bashrc to colorize login, for when booting into non-gui)

shopt -s histappend
shopt -s checkwinsize

# fzf — fuzzy finder bash integration (installed via Homebrew)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
