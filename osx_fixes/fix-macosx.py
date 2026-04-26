#!/usr/bin/env python3
"""
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  REFERENCE EXAMPLE ONLY — DO NOT RUN FOR ACTUAL SETUP
  For real macOS post-install configuration use: osx_post_install.sh
  All settings in this file are already covered there via `defaults write`.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

macOS preferences via CFPreferences API (PyObjC)
================================================
This file demonstrates how to read/write macOS preferences programmatically
using the native CFPreferences API instead of the `defaults` CLI tool.

When to use CFPreferences instead of `defaults write`:
  - Atomic read-modify-write (safe for array/dict values like orderedItems)
  - No need to restart cfprefsd — changes apply immediately
  - Works with typed values (bool, int, array, dict) without conversion quirks
  - Useful when a key stores a complex structure you need to partially update
  - Useful for reading/inspecting unknown preference domains during research

Requirements:
    pip install pyobjc-framework-Cocoa

Usage:
    python3 fix-macosx.py
"""

import sys

try:
    from Foundation import (
        NSMutableArray,
        NSMutableDictionary,
        CFPreferencesCopyValue,
        CFPreferencesCopyKeyList,
        CFPreferencesSetValue,
        CFPreferencesSynchronize,
        kCFPreferencesCurrentUser,
        kCFPreferencesAnyHost,
    )
except ImportError:
    print("PyObjC not found. Install with: pip install pyobjc-framework-Cocoa")
    sys.exit(1)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def pref_read(key: str, domain: str) -> object:
    """Read a single preference value."""
    return CFPreferencesCopyValue(key, domain, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)


def pref_write(key: str, value: object, domain: str) -> None:
    """Write a preference value and flush it to disk immediately."""
    CFPreferencesSetValue(key, value, domain, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)
    CFPreferencesSynchronize(domain, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)


def pref_list(domain: str) -> list:
    """Return all preference keys for a given domain."""
    keys = CFPreferencesCopyKeyList(domain, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)
    return list(keys) if keys else []


# ---------------------------------------------------------------------------
# Fixes
# ---------------------------------------------------------------------------

def fix_spotlight() -> None:
    """
    Disable Spotlight web search suggestions.

    Spotlight stores its search category config as an array of dicts under
    the key 'orderedItems'. We preserve all existing categories but flip
    'enabled' to False for MENU_WEBSEARCH and MENU_SPOTLIGHT_SUGGESTIONS.

    Equivalent defaults write (less safe for array mutation):
        defaults write com.apple.spotlight orderedItems -array ...
    """
    DOMAIN = "com.apple.Spotlight"
    KEY = "orderedItems"
    DISABLE = {"MENU_WEBSEARCH", "MENU_SPOTLIGHT_SUGGESTIONS"}

    DEFAULT_ITEMS = [
        {"enabled": True,  "name": "APPLICATIONS"},
        {"enabled": False, "name": "MENU_SPOTLIGHT_SUGGESTIONS"},
        {"enabled": True,  "name": "MENU_CONVERSION"},
        {"enabled": True,  "name": "MENU_EXPRESSION"},
        {"enabled": True,  "name": "MENU_DEFINITION"},
        {"enabled": True,  "name": "SYSTEM_PREFS"},
        {"enabled": True,  "name": "DOCUMENTS"},
        {"enabled": True,  "name": "DIRECTORIES"},
        {"enabled": True,  "name": "PRESENTATIONS"},
        {"enabled": True,  "name": "SPREADSHEETS"},
        {"enabled": True,  "name": "PDF"},
        {"enabled": True,  "name": "MESSAGES"},
        {"enabled": True,  "name": "CONTACT"},
        {"enabled": True,  "name": "EVENT_TODO"},
        {"enabled": True,  "name": "IMAGES"},
        {"enabled": True,  "name": "BOOKMARKS"},
        {"enabled": True,  "name": "MUSIC"},
        {"enabled": True,  "name": "MOVIES"},
        {"enabled": True,  "name": "FONTS"},
        {"enabled": True,  "name": "MENU_OTHER"},
        {"enabled": False, "name": "MENU_WEBSEARCH"},
    ]

    current = pref_read(KEY, DOMAIN)

    if not current:
        # No existing config — write the full default with our changes applied
        new_items = DEFAULT_ITEMS
    else:
        new_items = NSMutableArray.new()
        for item in current:
            if "name" not in item or "enabled" not in item:
                print(f"  [skip] unexpected item format: {item}")
                new_items.append(item)
                continue

            if item["name"] in DISABLE:
                entry = NSMutableDictionary.dictionaryWithDictionary_(item)
                entry.setObject_forKey_(False, "enabled")
                new_items.append(entry)
            else:
                new_items.append(item)

    pref_write(KEY, new_items, DOMAIN)
    print("  [ok] Spotlight web suggestions disabled")


def fix_safari_search() -> None:
    """
    Disable Safari's separate 'Spotlight Suggestions' metric reporting.

    Safari has its own UniversalSearchEnabled flag independent of system
    Spotlight settings — it must be disabled separately.

    Equivalent defaults write:
        defaults write com.apple.Safari UniversalSearchEnabled -bool false
        defaults write com.apple.Safari SuppressSearchSuggestions -bool true
    """
    DOMAIN = "com.apple.Safari"
    pref_write("UniversalSearchEnabled", False, DOMAIN)
    pref_write("SuppressSearchSuggestions", True, DOMAIN)
    print("  [ok] Safari search suggestions disabled")


# ---------------------------------------------------------------------------
# Example: read / inspect preferences (useful for exploring unknown domains)
# ---------------------------------------------------------------------------

def inspect_domain(domain: str) -> None:
    """Print all keys and values for a given preference domain."""
    keys = pref_list(domain)
    if not keys:
        print(f"  [empty] no preferences found for {domain}")
        return
    print(f"  {domain} ({len(keys)} keys):")
    for key in sorted(keys):
        value = pref_read(key, domain)
        print(f"    {key} = {value!r}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    print("==> Fixing Spotlight privacy settings...")
    fix_spotlight()

    print("==> Fixing Safari search settings...")
    fix_safari_search()

    # Uncomment to inspect any domain interactively:
    # inspect_domain("com.apple.Safari")
    # inspect_domain("com.apple.spotlight")

    print("\nDone. Log out and back in if changes don't appear immediately.")
