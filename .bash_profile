# Source .bashrc for interactive non-login shells
[[ -s ~/.bashrc ]] && source ~/.bashrc

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
	# [[ -s ~/.bashrc ]] && source ~/.bashrc
done;
unset file;

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Update LINES and COLUMNS after each command
shopt -s checkwinsize;

# Enable ** for recursive glob matching (e.g. ls **/*.txt)
shopt -s globstar;

# Show substituted history command in prompt before executing (!! safety net)
shopt -s histverify;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Save multi-line commands as one command
shopt -s cmdhist;

# Do not autocomplete when accidentally pressing Tab on an empty line
shopt -s no_empty_cmd_completion;

# Allow `cd` into variables containing paths (e.g. export projects="$HOME/projects")
shopt -s cdable_vars;

# Bash completion (Homebrew bash-completion@2)
if command -v brew &>/dev/null && [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi
