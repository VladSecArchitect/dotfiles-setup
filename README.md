# macOS Dotfiles

Shell configuration and system setup for macOS. Security-oriented profile (AppSec / penetration testing).

## File Structure

| File | Purpose |
|------|---------|
| `.bash_profile` | Login shell entry point — loads all other dotfiles |
| `.exports` | Environment variables (`EDITOR`, `HISTSIZE`, locale, etc.) |
| `.path` | `PATH` additions — Homebrew, LLVM, toolchains |
| `.bash_aliases` | Shell aliases only (no functions) |
| `.functions` | Larger shell utility functions |
| `.bash_prompt` | PS1/PS2 prompt (Solarized theme, git integration) |
| `.inputrc` | GNU Readline key bindings and completion settings |
| `.extra.example` | Template for machine-specific overrides (not committed) |
| `osx_fixes/osx_post_install.sh` | Full macOS setup script — `defaults write`, `pmset`, Homebrew |
| `osx_fixes/Brewfile` | Homebrew CLI packages |
| `osx_fixes/Caskfile` | Homebrew GUI applications |
| `setup.sh` | Bootstrap entry point for a new machine |

## Installation

```bash
git clone <repo> ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

Or apply macOS defaults separately:

```bash
bash osx_fixes/osx_post_install.sh
```

---

## Aliases Reference

### 1. Terminal Navigation

| Command | Description |
|---------|-------------|
| `..` / `cd..` | Go back 1 directory level |
| `...` | Go back 2 levels |
| `.3` … `.6` | Go back 3–6 levels |
| `~` / `home` | Go to home directory |
| `back` | Go to previous directory (`cd -`) |
| `c` | Clear terminal display |
| `cls` | Clear screen and scrollback buffer |
| `mcd <dir>` | Create directory and `cd` into it |
| `cd` | Overridden: always lists contents after navigating |
| `reload_bashrc` | Reload `~/.bash_profile` and print confirmation |

---

### 2. Make Terminal Better

| Command | Description |
|---------|-------------|
| `ls` | `ls -FAGhp` — color, indicators, human-readable sizes |
| `ll` | Long listing with hidden files |
| `la` | All files including dotfiles |
| `ld` | List directories only |
| `lt` | Sort by date, oldest first |
| `ltr` | Sort by date, newest first |
| `lr` | Full recursive directory listing as tree |
| `l` | Compact listing with indicators |
| `less` | `less -FSRXc` — quit if short, no clear on exit |
| `grep` | `grep -n` — always show line numbers |
| `grep2` | Plain `grep` without modifications |
| `edit <file>` | Open file in Sublime Text |
| `f` | Open current directory in Finder |
| `which` | `type -all` — find all instances of executable |
| `path` | Print each `$PATH` entry on its own line |
| `show_options` | Display current bash `shopt` settings |
| `fix_stty` | Restore terminal settings when corrupted |
| `cic` | Enable case-insensitive tab completion |
| `trash <file>` | Move file to macOS Trash (safe delete) |
| `ql <file>` | Preview file with macOS QuickLook |
| `DT` | Pipe output to `~/Desktop/terminalOut.txt` |
| `h` | Show command history |
| `his-20` | Show last 20 history entries |
| `he` | Export history to file (share between sessions) |
| `hi` | Import history from file (share between sessions) |
| `hgrep <term>` | Search command history |
| `machoview` | Open file in MachOView |
| `mans <cmd> <term>` | Search a man page for a term (highlighted, paginated) |
| `showa <pattern>` | Find aliases matching a pattern |
| `s [path]` | Open current directory (or path) in Sublime Text |
| `v [path]` | Open current directory (or path) in Vim |
| `o [path]` | Open current directory (or path) with `open` |
| `tre` | `tree` with hidden files, color, no `.git`, dirs first |

---

### 3. File and Folder Management

| Command | Description |
|---------|-------------|
| `cp` | `cp -iv` — interactive, verbose |
| `mv` | `mv -iv` — interactive, verbose |
| `mkdir` | `mkdir -pv` — create parents, verbose |
| `zipf <dir>` | Create a zip archive of a folder |
| `numFiles` | Count non-hidden files in current directory |
| `make1mb` / `make5mb` / `make10mb` | Create test files of 1, 5, or 10 MB |
| `ax <file>` | Make file executable (`chmod a+x`) |
| `cdf` | `cd` to the frontmost Finder window directory |
| `extract <file>` | Extract any archive: tar.gz, zip, 7z, rar, xz, zst, … |
| `fs [path]` | Show size of a file or total size of a directory |
| `gz <file>` | Compare original vs gzipped file size |
| `tar_protect <src> <out.tar.enc>` | Compress and AES-256 encrypt a folder (password from clipboard) |
| `zip_protect <file> <out.zip>` | Create a password-protected zip (password from clipboard) |
| `encrypt_file <in> <out>` | Encrypt a file with AES-256-CBC |
| `decrypt_file <in> <out>` | Decrypt a file encrypted with AES-256-CBC |
| `dataurl <file>` | Create a `data:` URL from a file |

---

### 4. Searching

| Command | Description |
|---------|-------------|
| `qfind <name>` | `find . -name` — quick file search |
| `ff <name>` | Find file by exact name in current directory tree |
| `ffs <prefix>` | Find files whose name starts with prefix |
| `ffe <suffix>` | Find files whose name ends with suffix |
| `todos` | List all `TODO`, `FIXME`, `HACK` lines in the project |
| `spotlight <name>` | Search for a file using macOS Spotlight metadata |

---

### 5. Process Management

| Command | Description |
|---------|-------------|
| `findPid <name>` | Find PID(s) of a process by name |
| `memHogsTop` | Top 20 memory consumers (via `top`) |
| `memHogsPs` | Top 10 memory consumers (via `ps`) |
| `cpu_hogs` | Top 10 CPU consumers |
| `topForever` | Continuous `top` every 10 seconds sorted by CPU |
| `ttop` | `top` optimized for low resource usage |
| `cpu` | `top` sorted by CPU usage |
| `mem` | `top` sorted by memory (RSS) |
| `my_ps` | List processes owned by current user |

---

### 6. Networking

| Command | Description |
|---------|-------------|
| `ping` | `ping -c 5` — send exactly 5 packets |
| `ports` | Show all listening ports |
| `myip` | Public IPv4/IPv6 address |
| `ip4` / `ip6` | Force IPv4 or IPv6 public IP |
| `myip-full` | Full IP info with geolocation (JSON) |
| `localip` | Local IP address on `en0` |
| `ip` | Public IP, ignoring `.curlrc` |
| `ipf` | Detailed IP info from ipinfo.io |
| `netcheck` | Quick connectivity test (`ping 8.8.8.8`) |
| `netCons` | Show all open TCP/IP sockets |
| `flushDNS` | Flush the DNS cache |
| `lsock` | All open sockets |
| `lsockU` | UDP sockets only |
| `lsockT` | TCP sockets only |
| `ipInfo0` / `ipInfo1` | Connection info for `en0` / `en1` |
| `openPorts` | All listening connections |
| `showBlocked` | Show PF firewall rules |
| `netstat_osx` | Network connections (macOS `lsof` equivalent of netstat) |
| `ii` | Display host info: users, uptime, network, public IP |
| `killport <port>` | Kill the process listening on a given port |

---

### 7. Systems Operations & Information

| Command | Description |
|---------|-------------|
| `mountReadWrite` | Remount root filesystem read-write |
| `purge` | Free up inactive memory (`sudo purge`) |
| `cleanupDS` | Recursively delete `.DS_Store` files |
| `emptytrash` | Empty Trash and clean system logs |
| `showhidden` | Show hidden files in Finder |
| `hidehidden` | Hide hidden files in Finder |
| `cleanupLS` | Clean LaunchServices database (fixes "Open With" duplicates) |
| `screensaverDesktop` | Run screensaver on the Desktop |
| `stfu` | Mute system volume |
| `tmlog` | Show Time Machine log for the last 30 minutes |
| `mountall` | Mount all connected FireWire disks |
| `unmountall` | Unmount all connected FireWire disks |

---

### 8. Web Development

| Command | Description |
|---------|-------------|
| `apacheEdit` | Edit Apache config (`httpd.conf`) |
| `apacheRestart` | Graceful Apache restart |
| `apachet` | Test Apache config and dump virtual hosts |
| `apacher` | Hard Apache restart |
| `editHosts` | Edit `/etc/hosts` |
| `herr` | Tail Apache error log |
| `apacheLogs` | Follow Apache error log with `less` |
| `httpHeaders <url>` | Show all HTTP response headers (`curl -I -L`) |
| `httpDebug <url>` | Show DNS, connect, transfer timing for a URL |
| `server [port]` | Start an HTTP server in the current directory (default port 8000) |
| `phpserver [port]` | Start a PHP dev server on `en1` IP (default port 4000) |
| `diff <a> <b>` | Git colored word-diff instead of standard `diff` |

---

### 9. Git

| Command | Description |
|---------|-------------|
| `gs` / `gst` | `git status` |
| `gd` | `git diff` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gpl` | `git pull` |
| `gp` / `gps` | `git push` |
| `gl` | `git log --oneline --graph --decorate -20` |
| `gb` | `git branch` |
| `gco` | `git checkout` |

---

### 10. Docker

| Command | Description |
|---------|-------------|
| `d` | `docker` |
| `dc` | `docker compose` |
| `dps` | `docker ps` with formatted table (name, status, ports) |
| `dclean` | `docker system prune -f` — remove unused resources |
| `dlogs` | `docker logs -f` — follow container logs |
| `dexec` | `docker exec -it` — interactive shell into container |

---

### 11. Misc

| Command | Description |
|---------|-------------|
| `chrome` | Open Google Chrome |
| `safari` | Open Safari |
| `bp` | Open `.bash_profile` in `$EDITOR` |
| `src` | Reload bash config (`source ~/.bash_profile`) |
| `cl` | Copy output of last command to clipboard |
| `cpwd` | Copy current directory path to clipboard |
| `pubkey` | Copy SSH public key (`id_ed25519.pub`) to clipboard |
| `tn` | Trim trailing newlines from output |
| `rmdbc` | Remove Dropbox conflicted copy files |
| `brewup` | `brew update && brew upgrade && brew cleanup && brew doctor` |
| `tp` | Create and open a `todo.taskpaper` file in TaskPaper |

---

### 12. AppSec / Security

#### Encoding & Decoding

| Command | Description |
|---------|-------------|
| `b64e` | Base64 encode |
| `b64d` | Base64 decode |
| `urlencode <str>` | URL-encode a string |
| `urldecode <str>` | URL-decode a string |
| `hex_encode <str>` | Hex-encode a string |
| `hex_decode <hex>` | Hex-decode a string |
| `rot13` | ROT13 cipher (pipe input) |
| `escape <str>` | UTF-8-encode a string of Unicode symbols to `\xNN` |
| `unidecode <str>` | Decode `\x{ABCD}`-style Unicode escape sequences |
| `codepoint <char>` | Print Unicode code point of a character (`U+XXXX`) |

#### Hashing

| Command | Description |
|---------|-------------|
| `md5str <str>` | MD5 hash of a string |
| `sha1str <str>` | SHA-1 hash of a string |
| `sha256str <str>` | SHA-256 hash of a string |
| `sha1file <file>` | SHA-1 hash of a file |
| `sha256file <file>` | SHA-256 hash of a file |

#### HTTP / Network Recon

| Command | Description |
|---------|-------------|
| `headers <url>` | Show all response headers |
| `httpcode <url>` | Show HTTP status code only |
| `secheaders <url>` | Show only security-relevant response headers |
| `test_methods <url>` | Test all HTTP methods (GET, POST, PUT, …) and show status codes |
| `extract_urls <file>` | Extract all URLs from file or stdin |
| `sniff` | Sniff unencrypted HTTP on `en0` (tcpdump) |
| `listen` | Active TCP listening ports |
| `connections` | Established connections grouped by process |
| `digall <domain>` | DNS: all record types for a domain (alias) |
| `digga <domain>` | DNS: all record types for a domain (function, same as `digall`) |
| `wh <domain>` | WHOIS lookup |
| `arpt` | ARP table — find hosts on local network |

#### TLS / Certificates

| Command | Description |
|---------|-------------|
| `sslcheck <host>` | TLS cert info: subject, issuer, dates, SANs |
| `getcertnames <host>` | Print all Common Names and SANs from a live certificate |
| `get_cert <host>` | Download PEM certificate from live HTTPS host |
| `cert_chain <host>` | Full certificate chain from live host |
| `cert_info <file.pem>` | Inspect a local PEM certificate |
| `pem2der <file.pem>` | Convert PEM → DER |
| `der2pem <file.der>` | Convert DER → PEM |

#### JWT

| Command | Description |
|---------|-------------|
| `jwt <token>` | Decode JWT header and payload (no signature validation) |

#### Password & Token Generation

| Command | Description |
|---------|-------------|
| `randpass [len]` | Random password (default 20 chars, mixed charset) |
| `generate_password` | 16-char password with symbols |
| `generate_human_password` | 16-char alphanumeric password |
| `randtoken [len]` | Random hex token (default 32 chars) |
| `uuid` | Generate a UUID v4 |

#### Filesystem Security

| Command | Description |
|---------|-------------|
| `find_suid [path]` | Find SUID binaries |
| `find_sgid [path]` | Find SGID binaries |
| `find_ww [path]` | Find world-writable files |

#### macOS Security

| Command | Description |
|---------|-------------|
| `sip_status` | Check SIP (System Integrity Protection) status |
| `gatekeeper` | Check Gatekeeper status |
| `keychain_get <service>` | Retrieve password from Keychain by service name |
| `keychain_list` | List all Keychain account entries |

#### Docker Security

| Command | Description |
|---------|-------------|
| `docker_caps <container>` | Show container capabilities (`CapAdd`) |
| `docker_priv` | Find containers running with `--privileged` or host network |

#### Android Reverse Engineering

| Command | Description |
|---------|-------------|
| `dex2jar <file.apk>` | Convert APK/DEX to JAR using dex2jar |

#### Git Security

| Command | Description |
|---------|-------------|
| `git_secrets` | Search all git history for passwords, tokens, API keys |
| `git_find <str>` | Find all commits that added or removed a specific string |

---

### 13. Misc / Tools

| Command | Description |
|---------|-------------|
| `tp` | Create `todo.taskpaper` in current directory and open in TaskPaper |
| `zi` | Jump to a directory with zoxide (smarter `cd`) |

---

## References

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [paulmillr/dotfiles](https://github.com/paulmillr/dotfiles)
- [holman/dotfiles](https://github.com/holman/dotfiles)
- [necolas/dotfiles](https://github.com/necolas/dotfiles)
- [sidaf/dotfiles](https://github.com/sidaf/dotfiles) — security-focused
- [rickellis/BashRC](https://github.com/rickellis/BashRC)
- [unixorn/git-extra-commands](https://github.com/unixorn/git-extra-commands)
- [dotfiles.github.io](https://dotfiles.github.io/)
