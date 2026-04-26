#!/bin/bash
# macOS post-install configuration
# Inspired by: https://github.com/mathiasbynens/dotfiles/blob/main/.macos
# Tested on: macOS 15 Sequoia (Apple Silicon)

set -euo pipefail

# Close System Preferences / System Settings (renamed in macOS 13+)
if [[ $(sw_vers -productVersion | cut -d. -f1) -ge 13 ]]; then
    osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
else
    osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true
fi

# Ask for sudo upfront and keep session alive for the duration of the script
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# General UI / UX
###############################################################################

echo "==> Configuring General UI..."

# Standby delay: 24 h (default is 1 h — prevents battery drain on sleep)
sudo pmset -a standbydelay 86400

# Disable startup sound
sudo nvram SystemAudioVolume=" "

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Faster window resize animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Sidebar icon size: medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Disable focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Don't auto-terminate inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Reduce menu bar / window transparency (improves readability and GPU load)
defaults write com.apple.universalaccess reduceTransparency -bool true

# Show ASCII control characters with caret notation in text views (useful for debugging)
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Help Viewer: open as regular window, not floating above everything else
defaults write com.apple.helpviewer DevMode -bool true

# Disable Resume system-wide (don't reopen windows after logout)
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Show IP address / hostname when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically on freeze
sudo systemsetup -setrestartfreeze on 2>/dev/null || true

# Clean up "Open With" menu duplicates
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
    -kill -r -domain local -domain system -domain user

# Disable "Are you sure you want to open this application?" dialog
# NOTE: reduces friction but bypasses Gatekeeper prompt — intentional for dev/research use
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set computer name (as done via System Settings → Sharing)
# sudo scutil --set ComputerName  "hostname"
# sudo scutil --set HostName      "hostname"
# sudo scutil --set LocalHostName "hostname"
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "hostname"

# Set highlight color to green (personal preference)
# defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Disable smooth scrolling (uncomment on older Macs with broken animation)
# defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Never go into computer sleep mode (too aggressive for laptops; use pmset manually)
# sudo systemsetup -setcomputersleep Off > /dev/null

# Disable Notification Center and remove the menu bar icon (too aggressive — disables NC entirely)
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null


###############################################################################
# Trackpad, Mouse, Keyboard & Input
###############################################################################

echo "==> Configuring Trackpad & Input..."

# Tap-to-click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Bottom-right corner → right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Scroll wheel + Ctrl → zoom; zoom follows keyboard focus
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable three-finger tap and vertical swipe
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -bool false

# Disable "natural" (reversed) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Full keyboard access: Tab works in all controls (e.g. modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Better Bluetooth audio quality
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Key repeat — fast repeat instead of accent popup
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable autocorrect, autocapitalization, smart dashes, smart quotes, period substitution
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Language and locale
defaults write NSGlobalDomain AppleLanguages -array "en" "ru"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Show language menu on login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
# sudo systemsetup -settimezone "Europe/Brussels" > /dev/null

# Stop iTunes/Music from responding to keyboard media keys
# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null


###############################################################################
# SSD-specific tweaks
# SKIP on Apple Silicon — hibernation is managed by firmware; these commands
# can corrupt the sleep image and break wake-from-sleep on M-series Macs.
###############################################################################

# sudo pmset -a hibernatemode 0
# sudo rm /private/var/vm/sleepimage
# sudo touch /private/var/vm/sleepimage
# sudo chflags uchg /private/var/vm/sleepimage


###############################################################################
# Screen & Screenshots
###############################################################################

echo "==> Configuring Screen..."

# Font smoothing on external (non-Apple) displays
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Require password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screenshots: folder, format, no shadow
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
killall SystemUIServer 2>/dev/null || true


###############################################################################
# Save & Print dialogs
###############################################################################

echo "==> Configuring Dialogs..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true


###############################################################################
# Finder
###############################################################################

echo "==> Configuring Finder..."

# Open new windows in home directory
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Disable window animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Allow quitting via ⌘Q
defaults write com.apple.finder QuitMenuItem -bool true

# Show full POSIX path in window title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Default search: current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Sort folders first, group by Kind
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"

# List view by default (icnv=icon, clmv=column, Flwv=gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show status bar, path bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Show hidden files and all extensions
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Warn before changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

# No warning before emptying trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show ~/Library and /Volumes (hidden by default)
chflags nohidden ~/Library
sudo chflags nohidden /Volumes

# Spring loading for directories (drag-hover to open)
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Show drives and removable media on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Automatically open a Finder window when a new volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Don't create .DS_Store on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Skip disk image checksum verification (safe for trusted sources; saves time)
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Desktop & icon views: show item info, snap to grid, bigger icons
for plist in ~/Library/Preferences/com.apple.finder.plist; do
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true"   "$plist" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :DesktopViewSettings:IconViewSettings:showItemInfo bool true" "$plist"
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true"  "$plist" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings:showItemInfo bool true" "$plist"
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true"   "$plist" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :StandardViewSettings:IconViewSettings:showItemInfo bool true" "$plist"
    /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false"   "$plist" 2>/dev/null || true
    for view in DesktopViewSettings:IconViewSettings FK_StandardViewSettings:IconViewSettings StandardViewSettings:IconViewSettings; do
        /usr/libexec/PlistBuddy -c "Set :${view}:arrangeBy grid"   "$plist" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Set :${view}:gridSpacing 100"  "$plist" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Set :${view}:iconSize 80"      "$plist" 2>/dev/null || true
    done
done

# AirDrop over Ethernet and on older Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Expand File Info panes: General, Open With, Sharing & Permissions
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

killall Finder 2>/dev/null || true


###############################################################################
# Dock
###############################################################################

echo "==> Configuring Dock..."

defaults write com.apple.dock tilesize -int 28
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 74
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock mouse-over-hilite-stack -bool true
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don't group windows by app in Mission Control (use Exposé-style per-window view)
defaults write com.apple.dock expose-group-by-app -bool false

# Reset Launchpad layout (clean slate on new setup)
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete 2>/dev/null || true

# Hot corners
# Values: 0=noop 2=Mission Control 3=App Windows 4=Desktop
#         5=Screen Saver 10=Sleep Display 11=Launchpad 12=Notification Center
defaults write com.apple.dock wvous-tl-corner -int 2   # top-left  → Mission Control
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 4   # top-right → Desktop
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 5   # bot-left  → Screen Saver
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 10  # bot-right → Sleep Display
defaults write com.apple.dock wvous-br-modifier -int 0

killall Dock 2>/dev/null || true


###############################################################################
# Safari
###############################################################################

echo "==> Configuring Safari..."

defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari PreloadTopHit -bool false
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari ShowIconsInTabs -bool true
defaults write com.apple.Safari DownloadsPath -string "~/Downloads/Safari"
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Developer tools
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Tab key highlights all page elements
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Backspace goes back in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Search: Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons (RSS, etc.) from bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable continuous spell check in page forms (catches typos without autocorrect)
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Security: disable AutoFill (passwords, credit cards, addresses)
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Security: disable Java and plugins (long deprecated, attack surface)
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Send Do Not Track header
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Auto-update extensions
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# Disable autocorrect in Safari
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

killall Safari 2>/dev/null || true


###############################################################################
# Google Chrome
###############################################################################

echo "==> Configuring Google Chrome..."
# NOTE: Most keys below are enterprise policies — apply locally via defaults write
# but require MDM / managed profile for guaranteed enforcement.

defaults write com.google.Chrome DownloadLocation -string "~/Downloads/Chrome"
defaults write com.google.Chrome AutoLaunchAtLogin -bool false
defaults write com.google.Chrome MediaPlaybackRequiresUserGesture -bool true
defaults write com.google.Chrome MetricsReportingEnabled -bool false
defaults write com.google.Chrome DeveloperToolsEnabled -bool true
defaults write com.google.Chrome HardwareAccelerationModeEnabled -bool false

# Disable backswipe navigation (too easy to trigger accidentally)
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# Keep download warnings enabled (disable only when testing malware samples)
# defaults write com.google.Chrome DownloadWarningsEnabled -bool false

killall "Google Chrome" 2>/dev/null || true


###############################################################################
# Mail
###############################################################################

echo "==> Configuring Mail..."
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"
# ⌘ + Enter to send
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"
# Threaded view, sorted by received date (oldest at top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"


###############################################################################
# Terminal
###############################################################################

echo "==> Configuring Terminal..."
# Don't prompt before quitting iTerm2
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

defaults write com.apple.Terminal AutoMarkPromptLines -bool false
defaults write com.apple.Terminal ShowLineMarks -int 0
defaults write com.apple.terminal StringEncodings -array 4
# Enable Secure Keyboard Entry (prevents other apps from reading keystrokes)
# https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Enable "focus follows mouse" for Terminal.app and X11 apps
# defaults write com.apple.terminal FocusFollowsMouse -bool true
# defaults write org.x.X11 wm_ffm -bool true

# Apply Solarized Dark theme in Terminal.app (requires ~/init/ folder with theme files)
# osascript <<EOD
# tell application "Terminal"
#   local allOpenedWindows
#   local initialOpenedWindows
#   local windowID
#   set themeName to "Solarized Dark xterm-256color"
#   set initialOpenedWindows to id of every window
#   do shell script "open '$HOME/init/" & themeName & ".terminal'"
#   delay 1
#   set default settings to settings set themeName
#   set allOpenedWindows to id of every window
#   repeat with windowID in allOpenedWindows
#     if initialOpenedWindows does not contain windowID then
#       close (every window whose id is windowID)
#     else
#       set current settings of tabs of (every window whose id is windowID) to settings set themeName
#     end if
#   end repeat
# end tell
# EOD

# Apply Solarized Dark theme in iTerm2 (requires ~/init/ folder with theme file)
# open "${HOME}/init/Solarized Dark.itermcolors"


###############################################################################
# TextEdit
###############################################################################

echo "==> Configuring TextEdit..."
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4


###############################################################################
# QuickTime Player
###############################################################################

echo "==> Configuring QuickTime Player..."
# Auto-play video when opened
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true


###############################################################################
# Activity Monitor
###############################################################################

echo "==> Configuring Activity Monitor..."
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor IconType -int 5      # CPU graph in Dock icon
defaults write com.apple.ActivityMonitor ShowCategory -int 0  # Show all processes
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


###############################################################################
# Disk Utility
###############################################################################

echo "==> Configuring Disk Utility..."
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


###############################################################################
# Time Machine
###############################################################################

echo "==> Configuring Time Machine..."
# Don't prompt to use new drives as backup destination
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
# NOTE: `tmutil disablelocal` subcommand was removed in macOS 11 (Big Sur) — will fail on modern macOS
# hash tmutil &>/dev/null && sudo tmutil disablelocal


###############################################################################
# Photos
###############################################################################

echo "==> Configuring Photos..."
# Prevent Photos from opening automatically when iPhone/camera is connected
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


###############################################################################
# Messages
###############################################################################

echo "==> Configuring Messages..."
defaults write com.apple.messageshelper.MessageController SOInputLineSettings \
    -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings \
    -dict-add "automaticQuoteSubstitutionEnabled" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings \
    -dict-add "continuousSpellCheckingEnabled" -bool false


###############################################################################
# App Store & Software Update
###############################################################################

echo "==> Configuring App Store..."
defaults write com.apple.appstore WebKitDeveloperExtras -bool true
defaults write com.apple.appstore ShowDebugMenu -bool true
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1     # daily
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1  # security updates
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1      # download apps bought on other Macs
defaults write com.apple.commerce AutoUpdate -bool true               # auto-update App Store apps
# Allow the App Store to reboot machine on macOS updates (can cause unexpected reboots — disabled)
# defaults write com.apple.commerce AutoUpdateRestartRequired -bool true


###############################################################################
# Privacy & Telemetry
###############################################################################

echo "==> Configuring Privacy & Telemetry..."
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.assistant.support "Siri Data Sharing Opt-In Status" -int 2
defaults write com.apple.SubmitDiagInfo AutoSubmit -bool false 2>/dev/null || true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Prevent Spotlight from indexing external volumes mounted under /Volumes
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes" 2>/dev/null || true

# Spotlight: disable web search suggestions
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled"=1;"name"="APPLICATIONS";}' \
    '{"enabled"=1;"name"="SYSTEM_PREFS";}' \
    '{"enabled"=1;"name"="DIRECTORIES";}' \
    '{"enabled"=1;"name"="PDF";}' \
    '{"enabled"=1;"name"="DOCUMENTS";}' \
    '{"enabled"=1;"name"="MESSAGES";}' \
    '{"enabled"=0;"name"="MENU_SPOTLIGHT_SUGGESTIONS";}' \
    '{"enabled"=0;"name"="MENU_WEBSEARCH";}' \
    '{"enabled"=0;"name"="MENU_OTHER";}'

# Hide Spotlight tray-icon
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Rebuild Spotlight index — run manually if Spotlight is broken (takes several minutes)
# killall mds > /dev/null 2>&1
# sudo mdutil -i on / > /dev/null
# sudo mdutil -E / > /dev/null


###############################################################################
# Security
###############################################################################

echo "==> Configuring Security..."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on

sudo pmset -a womp 0

sudo systemsetup -setremotelogin off 2>/dev/null || true
sudo systemsetup -setremoteappleevents off 2>/dev/null || true


###############################################################################
# Legacy / Obsolete (kept for reference)
###############################################################################

# Enable the debug menu in Address Book (legacy app, pre-Contacts)
defaults write com.apple.addressbook ABShowDebugMenu -bool true

# Enable Dashboard dev mode (keeps widgets on the desktop)
# NOTE: Dashboard was removed in macOS 15 Sequoia
defaults write com.apple.dashboard devmode -bool true

# Enable the debug menu in iCal (pre-macOS 10.8 only)
defaults write com.apple.iCal IncludeDebugMenu -bool true


###############################################################################
# GPGMail
###############################################################################

# Disable signing emails by default
defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false


###############################################################################
# Opera & Opera Developer
###############################################################################

defaults write com.operasoftware.Opera PMPrintingExpandedStateForPrint2 -boolean true
defaults write com.operasoftware.OperaDeveloper PMPrintingExpandedStateForPrint2 -boolean true


###############################################################################
# SizeUp.app
###############################################################################

defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true
defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false


###############################################################################
# Sublime Text
###############################################################################

# Install Sublime Text settings (requires init/ folder)
# cp -r init/Preferences.sublime-settings \
#   ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2>/dev/null


###############################################################################
# Transmission.app
###############################################################################

defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"
defaults write org.m0k.transmission DownloadLocationConstant -bool true
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false
defaults write org.m0k.transmission CheckRemoveDownloading -bool true
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false
# IP block list — source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission RandomPort -bool true


###############################################################################
# Twitter.app
###############################################################################

defaults write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false
defaults write com.twitter.twitter-mac MenuItemBehavior -int 1
defaults write com.twitter.twitter-mac ShowDevelopMenu -bool true
defaults write com.twitter.twitter-mac openLinksInBackground -bool true
defaults write com.twitter.twitter-mac ESCClosesComposeWindow -bool true
defaults write com.twitter.twitter-mac ShowFullNames -bool true
defaults write com.twitter.twitter-mac HideInBackground -bool true


###############################################################################
# Tweetbot.app
###############################################################################

# Bypass the t.co URL shortener
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true


###############################################################################
# Spectacle.app
###############################################################################

defaults write com.divisiblebyzero.Spectacle MakeLarger -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035a4d616b654c6172676572d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f7a7f8a939c9fa8b1c3c6cb0000000000000101000000000000001c000000000000000000000000000000cd
defaults write com.divisiblebyzero.Spectacle MakeSmaller -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035b4d616b65536d616c6c6572d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f7b808b949da0a9b2c4c7cc0000000000000101000000000000001c000000000000000000000000000000ce
defaults write com.divisiblebyzero.Spectacle MoveToBottomDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107d80035f10134d6f7665546f426f74746f6d446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072888d98a1afb2c0c9dbdee30000000000000101000000000000001d000000000000000000000000000000e5
defaults write com.divisiblebyzero.Spectacle MoveToBottomHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107d80035f10104d6f7665546f426f74746f6d48616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072858a959ea7aab3bcced1d60000000000000101000000000000001d000000000000000000000000000000d8
defaults write com.divisiblebyzero.Spectacle MoveToCenter -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002100880035c4d6f7665546f43656e746572d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70727f848f98a1a4adb6c8cbd00000000000000101000000000000001d000000000000000000000000000000d2
defaults write com.divisiblebyzero.Spectacle MoveToFullscreen -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002102e80035f10104d6f7665546f46756c6c73637265656ed2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072858a959ea7aab3bcced1d60000000000000101000000000000001d000000000000000000000000000000d8
defaults write com.divisiblebyzero.Spectacle MoveToLeftDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107b80035f10114d6f7665546f4c656674446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072868b969fadb0bec7d9dce10000000000000101000000000000001d000000000000000000000000000000e3
defaults write com.divisiblebyzero.Spectacle MoveToLeftHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107b80035e4d6f7665546f4c65667448616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70728186919aa3a6afb8cacdd20000000000000101000000000000001d000000000000000000000000000000d4
defaults write com.divisiblebyzero.Spectacle MoveToLowerLeft -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731113008002107b80035f100f4d6f7665546f4c6f7765724c656674d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70728489949dabafbdc6cfe1e4e90000000000000101000000000000001e000000000000000000000000000000eb
defaults write com.divisiblebyzero.Spectacle MoveToLowerRight -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731113008002107c80035f10104d6f7665546f4c6f7765725269676874d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e7072858a959eacb0bec7d0e2e5ea0000000000000101000000000000001e000000000000000000000000000000ec
defaults write com.divisiblebyzero.Spectacle MoveToNextDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731118008002107c80035f10114d6f7665546f4e657874446973706c6179d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072868b969fa8abb4bdcfd2d70000000000000101000000000000001d000000000000000000000000000000d9
defaults write com.divisiblebyzero.Spectacle MoveToNextThird -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035f100f4d6f7665546f4e6578745468697264d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f8186919aa3a6afb8cacdd20000000000000101000000000000001c000000000000000000000000000000d4
defaults write com.divisiblebyzero.Spectacle MoveToPreviousDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731118008002107b80035f10154d6f7665546f50726576696f7573446973706c6179d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70728a8f9aa3acafb8c1d3d6db0000000000000101000000000000001d000000000000000000000000000000dd
defaults write com.divisiblebyzero.Spectacle MoveToPreviousThird -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035f10134d6f7665546f50726576696f75735468697264d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f858a959ea7aab3bcced1d60000000000000101000000000000001c000000000000000000000000000000d8
defaults write com.divisiblebyzero.Spectacle MoveToRightDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107c80035f10124d6f7665546f5269676874446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072878c97a0aeb1bfc8dadde20000000000000101000000000000001d000000000000000000000000000000e4
defaults write com.divisiblebyzero.Spectacle MoveToRightHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107c80035f100f4d6f7665546f526967687448616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70728489949da6a9b2bbcdd0d50000000000000101000000000000001d000000000000000000000000000000d7
defaults write com.divisiblebyzero.Spectacle MoveToTopDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107e80035f10104d6f7665546f546f70446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072858a959eacafbdc6d8dbe00000000000000101000000000000001d000000000000000000000000000000e2
defaults write com.divisiblebyzero.Spectacle MoveToTopHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107e80035d4d6f7665546f546f7048616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e707280859099a2a5aeb7c9ccd10000000000000101000000000000001d000000000000000000000000000000d3
defaults write com.divisiblebyzero.Spectacle MoveToUpperLeft -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731111008002107b80035f100f4d6f7665546f55707065724c656674d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70728489949dabafbdc6cfe1e4e90000000000000101000000000000001e000000000000000000000000000000eb
defaults write com.divisiblebyzero.Spectacle MoveToUpperRight -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731111008002107c80035f10104d6f7665546f55707065725269676874d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e7072858a959eacb0bec7d0e2e5ea0000000000000101000000000000001e000000000000000000000000000000ec
defaults write com.divisiblebyzero.Spectacle RedoLastMove -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579456e61626c6564624b6579436f64655624636c617373110b008002100680035c5265646f4c6173744d6f7665d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70727f848f98a6aab8c1cadcdfe40000000000000101000000000000001e000000000000000000000000000000e6
defaults write com.divisiblebyzero.Spectacle UndoLastMove -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579456e61626c6564624b6579436f64655624636c6173731109008002100680035c556e646f4c6173744d6f7665d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70727f848f98a6aab8c1cadcdfe40000000000000101000000000000001e000000000000000000000000000000e6

# Kill affected third-party apps to apply changes
for app in "Address Book" \
    "Calendar" \
    "Contacts" \
    "Opera" \
    "SizeUp" \
    "Spectacle" \
    "Transmission" \
    "Tweetbot" \
    "Twitter" \
    "iCal"; do
    killall "${app}" &>/dev/null
done


###############################################################################
# Install Homebrew & packages
###############################################################################

echo ""
echo "==> System configuration complete. Log out or restart to apply all changes."
echo ""

echo "==> Installing Homebrew..."
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

echo "==> Installing packages from Brewfile..."
if [ -f "./Brewfile" ]; then
    brew bundle --file=./Brewfile
    echo "Brewfile complete."
else
    echo "Brewfile not found, skipping."
fi

if [ -f "./Caskfile" ]; then
    brew bundle --file=./Caskfile
    echo "Caskfile complete."
else
    echo "Caskfile not found, skipping."
fi


###############################################################################
# SSH
###############################################################################

echo "==> Configuring SSH..."
mkdir -p "$HOME/.ssh/sockets"
chmod 700 "$HOME/.ssh"
chmod 700 "$HOME/.ssh/sockets"

DOTFILES_DIR_SSH="$(cd "$(dirname "$0")/.." && pwd)"
SSH_CONFIG_SRC="$DOTFILES_DIR_SSH/.ssh/config"
SSH_CONFIG_DEST="$HOME/.ssh/config"

if [ -f "$SSH_CONFIG_SRC" ]; then
    ln -sf "$SSH_CONFIG_SRC" "$SSH_CONFIG_DEST"
    chmod 600 "$SSH_CONFIG_DEST"
    echo "Symlinked $SSH_CONFIG_SRC → $SSH_CONFIG_DEST"
else
    echo "  .ssh/config not found, skipping."
fi


###############################################################################
# Python REPL
###############################################################################

echo "==> Deploying Python REPL config..."
DOTFILES_DIR_PY="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$HOME/.python"
ln -sf "$DOTFILES_DIR_PY/python/pythonrc.py" "$HOME/.python/pythonrc.py"
ln -sf "$DOTFILES_DIR_PY/python/.pythonrc"   "$HOME/.pythonrc"
echo "Symlinked python/pythonrc.py → ~/.python/pythonrc.py"
echo "Symlinked python/.pythonrc   → ~/.pythonrc"


###############################################################################
# Claude Code — global settings
###############################################################################

echo "==> Deploying Claude Code settings..."
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_SRC="$DOTFILES_DIR/claude/settings.json"
CLAUDE_DEST="$HOME/.claude/settings.json"

if [ -f "$CLAUDE_SRC" ]; then
    mkdir -p "$HOME/.claude"
    ln -sf "$CLAUDE_SRC" "$CLAUDE_DEST"
    echo "Symlinked $CLAUDE_SRC → $CLAUDE_DEST"
else
    echo "claude/settings.json not found, skipping."
fi
