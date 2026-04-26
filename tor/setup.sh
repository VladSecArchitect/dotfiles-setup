#!/usr/bin/env bash
# Tor + Privoxy + Proxychains-ng — setup and usage guide for macOS
#
# References:
#   https://www.torproject.org
#   https://www.privoxy.org
#   https://github.com/rofl0r/proxychains-ng
#   https://spyboy.blog/2024/01/02/anonymize-your-traffic-with-proxychains-tor-a-comprehensive-guide/
#   https://www.whonix.org/wiki/Comparison_Of_Tor_with_CGI_Proxies,_Proxy_Chains,_and_VPN_Services
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │  WHEN TO USE WHAT                                                       │
# │                                                                         │
# │  torsocks <cmd>         — torify a single command (Tor-aware wrapper)   │
# │  proxychains4 <cmd>     — route any CLI tool through proxy chain        │
# │  curl --proxy 127.0.0.1:8118 — use Privoxy HTTP proxy                  │
# │  curl --socks5 127.0.0.1:9050 — use Tor SOCKS5 directly                │
# │                                                                         │
# │  Privoxy  — converts HTTP → SOCKS5(Tor). Needed for browsers/tools     │
# │             that only support HTTP proxies. Port 8118.                  │
# │  torsocks — best for single commands; Tor-specific, reliable            │
# │  proxychains — best for tools without native proxy support;             │
# │             also supports proxy chaining (multi-hop)                    │
# │                                                                         │
# │  NOTE: proxychains doesn't work with statically linked binaries (Go)   │
# └─────────────────────────────────────────────────────────────────────────┘

set -euo pipefail

# Detect Homebrew prefix (Apple Silicon vs Intel)
BREW_PREFIX="$(brew --prefix)"

###############################################################################
# Tor
###############################################################################
# Start Tor as a background service and enable auto-start on login.
# `brew services` handles launchd plist automatically — no manual
# ln -sfv / launchctl needed (that's the old pre-Homebrew-services approach).
brew services start tor

# Torrc location (edit with caution — wrong settings can break anonymity):
#   $BREW_PREFIX/etc/tor/torrc
# Reference: $BREW_PREFIX/etc/tor/torrc.sample

###############################################################################
# Privoxy — HTTP proxy that forwards to Tor SOCKS5
###############################################################################
# Chain: App → Privoxy (HTTP :8118) → Tor (SOCKS5 :9050) → Internet
#
# Use cases:
#   - Browsers/tools that only support HTTP proxies (not SOCKS)
#   - Filtering/ad-blocking on top of Tor
#   - System-wide HTTP proxy setting in macOS Network preferences

PRIVOXY_CONF="$BREW_PREFIX/etc/privoxy/config"

# forward-socks5 is better than forward-socks4a:
#   socks4a — DNS resolved remotely (no leak) but no IPv6, no UDP
#   socks5  — DNS resolved remotely + IPv6 support + auth support
if ! grep -q "^forward-socks5" "$PRIVOXY_CONF"; then
    echo "forward-socks5 / 127.0.0.1:9050 ." >> "$PRIVOXY_CONF"
    echo "Added forward-socks5 rule to $PRIVOXY_CONF"
fi

brew services start privoxy

###############################################################################
# Proxychains-ng — route arbitrary CLI tools through proxy chain
###############################################################################
# Chain: Tool → Proxychains → Tor SOCKS5 → Internet
#
# Use cases:
#   - OSINT tools, scrapers, recon tools without native proxy support
#   - Penetration testing (nmap, curl, sqlmap, etc.)
#   - Multi-hop proxy chains for traffic anonymization
#   - Pivoting through compromised internal hosts

PROXYCHAINS_CONF="$BREW_PREFIX/etc/proxychains.conf"

# Point to Tor SOCKS5
if ! grep -q "^socks5.*9050" "$PROXYCHAINS_CONF"; then
    # Comment out default socks4 proxy and add Tor socks5
    sed -i '' 's/^socks4 /#socks4 /' "$PROXYCHAINS_CONF"
    echo "socks5 127.0.0.1 9050" >> "$PROXYCHAINS_CONF"
    echo "Updated proxychains config to use Tor SOCKS5"
fi

# CRITICAL: Enable proxy_dns to prevent DNS leaks
# Without this, DNS queries bypass the proxy and leak your real IP
if ! grep -q "^proxy_dns" "$PROXYCHAINS_CONF"; then
    sed -i '' 's/^#proxy_dns/proxy_dns/' "$PROXYCHAINS_CONF" 2>/dev/null || \
    echo "proxy_dns" >> "$PROXYCHAINS_CONF"
    echo "Enabled proxy_dns in proxychains config (prevents DNS leaks)"
fi

###############################################################################
# Verify
###############################################################################
echo ""
echo "==> Verifying Tor is working..."
torsocks curl -s https://check.torproject.org/api/ip || echo "Tor not ready yet — try again in a few seconds"

echo ""
echo "Usage examples:"
echo "  torsocks curl https://check.torproject.org/api/ip"
echo "  proxychains4 curl https://ifconfig.me"
echo "  proxychains4 nmap -sT -p 80,443 example.com"
echo "  curl --proxy http://127.0.0.1:8118 https://ifconfig.me"
echo "  ALL_PROXY=socks5://127.0.0.1:9050 curl https://ifconfig.me"
echo ""
echo "DNS leak check:"
echo "  sudo tcpdump -i en0 'udp port 53'  — should see NO traffic when using torsocks/proxychains"
echo "  torsocks dig +short myip.opendns.com @resolver1.opendns.com"
echo ""
echo "Tor service management:"
echo "  brew services stop tor"
echo "  brew services restart tor"
echo "  brew services list | grep tor"
