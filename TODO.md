# TODO

## Разбить osx_post_install.sh на модули

Разбить монолитный `osx_fixes/osx_post_install.sh` на отдельные скрипты по компонентам:

```
osx_fixes/
  install/
    brew.sh         — Homebrew + пакеты из Brewfile/Caskfile
    python.sh       — pyenv, pip, pythonrc симлинки
    go.sh           — Go toolchain
    rust.sh         — rustup
    symlinks.sh     — симлинки всех dotfiles в ~
  osx_defaults.sh   — defaults write, pmset и т.д.
  osx_post_install.sh — оркестратор, вызывает модули по порядку
```

Каждый модуль должен иметь `set -euo pipefail` и быть запускаемым отдельно.
