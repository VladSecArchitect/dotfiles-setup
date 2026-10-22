# Firefox hardening (arkenfox)

`user.js` here is the **[arkenfox](https://github.com/arkenfox/user.js) user.js**
(v144, vendored verbatim — MIT, see the header in the file).

## Rules (per arkenfox)

- **Do NOT edit `user.js`.** It is maintained by the project; your own prefs go in
  **`user-overrides.js`**. The updater appends overrides to `user.js` (later entries
  win), so your changes survive updates.
  — [wiki 3.1 Overrides](https://github.com/arkenfox/user.js/wiki/3.1-Overrides)

## Keep it current

The vendored `user.js` is a pinned copy and goes stale. Refresh it with the official
scripts (run from this `firefox/` directory, with **Firefox closed**):

```sh
curl -O https://raw.githubusercontent.com/arkenfox/user.js/master/updater.sh
chmod +x updater.sh && ./updater.sh          # fetch latest user.js + append user-overrides.js
curl -O https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.sh
chmod +x prefsCleaner.sh && ./prefsCleaner.sh # reset inactive / deprecated prefs
```

Then copy the resulting `user.js` into your Firefox **profile** folder
(`about:profiles` → "Root Directory").
— [wiki 3.4 Apply & Update & Maintain](https://github.com/arkenfox/user.js/wiki/3.4-Apply-&-Update-&-Maintain)

## Removed: `firefox-privacy-restorer.py`

A 2017 third-party script (Shawn Anastasio) was removed because it:

- **overwrote `user.js`**, clobbering the arkenfox config in this same folder;
- set `privacy.donottrackheader.enabled` — **Do Not Track, which Mozilla removed in
  Firefox 135** (Dec 2024) as a fingerprinting/privacy risk, pointing users to
  [Global Privacy Control](https://support.mozilla.org/kb/global-privacy-control) instead;
- used long-removed prefs (`social.whitelist`) and was fully superseded by arkenfox
  (telemetry/health-report/experiments are all already disabled there).
