/*** arkenfox user-overrides.js
 *
 * Put your PERSONAL Firefox prefs HERE — never edit user.js directly.
 * The arkenfox updater appends this file to user.js (later entries win), so your
 * changes survive updates. See wiki 3.1 Overrides:
 *   https://github.com/arkenfox/user.js/wiki/3.1-Overrides
 *
 * Examples (uncomment / adjust to taste):
 ***/

// user_pref("browser.startup.homepage", "about:blank");
// user_pref("privacy.resistFingerprinting.letterboxing", true);   // [SETUP-HARDEN]
// user_pref("browser.download.dir", "/Users/<you>/Downloads");

/* NOTE: Do Not Track is intentionally NOT set here. Mozilla removed the DNT
 * setting in Firefox 135 (Dec 2024) as a fingerprinting/privacy risk and points
 * to Global Privacy Control (privacy.globalprivacycontrol.enabled) instead. */
