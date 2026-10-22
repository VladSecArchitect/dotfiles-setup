#!/usr/bin/env bash
#
# apt-setup.sh — install the CLI/security toolchain on Debian/Ubuntu (no Homebrew).
# The macOS Brewfile/Caskfile do not apply here; this is the Linux equivalent for the
# command-line tools (servers, AWS EC2, etc.). GUI apps are intentionally omitted.
#
# Usage:  bash linux/apt-setup.sh
# Safe to re-run (idempotent). Needs sudo for apt.

set -euo pipefail

command -v apt-get >/dev/null 2>&1 || { echo "apt-get not found — this script is for Debian/Ubuntu."; exit 1; }

echo "==> Enabling 'universe' (needed for proxychains4, zoxide, gobuster, …) and updating"
sudo add-apt-repository -y universe 2>/dev/null || true
sudo apt-get update -y

# ---------------------------------------------------------------------------
# CORE — present in apt on Ubuntu 22.04/24.04; installed in one batch
# ---------------------------------------------------------------------------
CORE=(
    # build / dev
    build-essential cmake ninja-build autoconf automake libtool pkg-config m4
    gdb binutils clang llvm
    python3 python3-pip python3-venv
    nodejs npm golang-go
    # version control & shell
    git git-lfs zsh bash-completion vim nano
    # everyday CLI
    curl wget rsync tmux htop tree jq moreutils ack highlight pandoc
    imagemagick p7zip-full unzip xz-utils shellcheck
    libimage-exiftool-perl        # exiftool
    # network / security
    nmap tcpdump socat tor torsocks privoxy sslscan nikto arp-scan arping
    yara radare2 hashcat john sqlmap aircrack-ng hydra apktool
)
echo "==> Installing core packages"
sudo apt-get install -y "${CORE[@]}"

# ---------------------------------------------------------------------------
# MODERN — apt names/availability vary by release; install individually and
# skip gracefully if a package is missing on this Ubuntu version.
# ---------------------------------------------------------------------------
MODERN=(
    ripgrep          # binary: rg
    bat              # binary: batcat (name clash) — symlinked to ~/.local/bin/bat below
    fd-find          # binary: fdfind  — symlinked to ~/.local/bin/fd below
    fzf
    zoxide           # 24.04 universe; may be absent on older releases
    tldr
    proxychains4     # from proxychains-ng; config: /etc/proxychains4.conf
    gobuster
    git-delta        # may be absent on 24.04 — falls through to the "not in apt" note
    testssl.sh
)
echo "==> Installing modern tools (skipping any not in this release's apt)"
for p in "${MODERN[@]}"; do
    if apt-cache show "$p" >/dev/null 2>&1; then
        sudo apt-get install -y "$p"
    else
        echo "  - skip (not in apt here): $p  — see 'NOT IN APT' below"
    fi
done

# ---------------------------------------------------------------------------
# Binary-name shims: Ubuntu renames bat->batcat and fd->fdfind. Symlink them to
# ~/.local/bin (already on PATH via ~/.path) so `bat`/`fd` work like on macOS.
# ---------------------------------------------------------------------------
mkdir -p "$HOME/.local/bin"
command -v batcat >/dev/null 2>&1 && ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
command -v fdfind >/dev/null 2>&1 && ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

cat <<'EOF'

==> Done.

NOT IN APT (install separately if you want them):
  eza      cargo install eza            # or the eza apt repo: https://github.com/eza-community/eza/blob/main/INSTALL.md
  ffuf     go install github.com/ffuf/ffuf/v2@latest
  semgrep  pipx install semgrep         # (sudo apt install pipx)
  trivy    official apt repo: https://trivy.dev/latest/getting-started/installation/
  git-delta (if skipped above)  cargo install git-delta   # or grab the .deb from its GitHub releases

Shell integration is already handled by the dotfiles: fzf (in ~/.bashrc), zoxide
(in ~/.bash_aliases); .gitconfig uses delta only if installed, else falls back to less.
EOF
