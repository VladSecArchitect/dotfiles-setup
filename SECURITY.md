# Security Policy

This repository is public. The committed tool configs are **sanitized**:

- `burp/*.json` — exported with empty credentials, scope and cookies, and no license key.
- `.ssh/config` — only commented example hosts; no real or internal hosts, and no keys.
- Real secrets (tokens, machine-specific config) live in `.extra`, which is **gitignored**
  and never committed.

[CI](.github/workflows/ci.yml) runs [gitleaks](https://github.com/gitleaks/gitleaks) on
every push and pull request to catch accidental secret commits, and ShellCheck lints the
shell scripts.

## Reporting a problem

If you find a secret accidentally committed here, or a vulnerability in one of the scripts,
please report it **privately** via
[GitHub Security Advisories](https://github.com/VladSecArchitect/dotfiles-setup/security/advisories/new)
instead of opening a public issue.
