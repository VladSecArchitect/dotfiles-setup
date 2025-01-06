#!/bin/bash
# Script for applying post-installation system preferences on macOS
# I was inspired by this: https://github.com/mathiasbynens/dotfiles/blob/main/.macos


# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName "0x68656C6C6F"
#sudo scutil --set HostName "0x68656C6C6F"
#sudo scutil --set LocalHostName "0x68656C6C6F"
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "0x68656C6C6F"


echo "Configuring Trackpad..."
# Enable tap-to-click on the trackpad
# Включить тап по трекпаду для клика
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Disable three-finger tap gesture
# Отключить жест тройного касания
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -bool false
# Disable three-finger vertical swipe gesture
# Отключить вертикальный свайп тремя пальцами
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -bool false
echo "Trackpad configuration complete."


echo "Configuring Terminal..."
# Configure Terminal to disable automatic prompt line marking
# Настройка Terminal для отключения автоматической маркировки строк с prompt
defaults write com.apple.Terminal AutoMarkPromptLines -bool false
# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

echo "Configuring Mail..."
# Configure Mail to disable inline attachment previews
# Настройка Mail для отключения предварительного просмотра вложений
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
# Disable including names when copying email addresses in Mail
# This ensures only the email address is copied, without the associated name.
# Это гарантирует копирование только email-адреса без связанного имени.
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Configuring Safari..."
# Display full URL in the address bar
# Показывать полный URL в адресной строке
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# Disable preloading Top Sites
# Отключить предварительную загрузку топ-сайтов
defaults write com.apple.Safari PreloadTopHit -bool false
# Disable opening "safe" files automatically after downloading
# Отключить автоматическое открытие "безопасных" файлов после загрузки
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# Enable Fraudulent Website Warnings
# Включить предупреждения о мошеннических веб-сайтах
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
# Enable the Develop menu
# Включить меню разработчика
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# Enable Web Inspector
# Включить Web Inspector
defaults write com.apple.Safari WebKitDeveloperExtras -bool true
# Show favicons in tabs
# Показать фавиконы в табах
defaults write com.apple.Safari ShowIconsInTabs -bool true
# Set the default download location
# Изменить папку для загрузок
defaults write com.apple.Safari DownloadsPath -string "~/Downloads/Safari"
killall Safari

echo "Configuring Google Chrome..."
# Set the default download folder
# Установить папку для загрузок по умолчанию
defaults write com.google.Chrome DownloadLocation -string "~/Downloads/Chrome"
# Prevent Chrome from auto-launching at login
# Запретить автозапуск Chrome при входе в систему
defaults write com.google.Chrome AutoLaunchAtLogin -bool false
# Disable autoplay for videos
# Отключить автоматическое воспроизведение видео
defaults write com.google.Chrome MediaPlaybackRequiresUserGesture -bool true
# Show the full URL in the address bar
# Показать полный URL в адресной строке
defaults write com.google.Chrome ShowFullURLs -bool true
# Disable camera and microphone access
# Отключить доступ к камере и микрофону
defaults write com.google.Chrome DisableMediaDevices -bool true
# Disable sending user activity data to Google
# Отключить сбор данных об активности пользователя
defaults write com.google.Chrome MetricsReportingEnabled -bool false
# Enable Developer Tools
# Включить инструменты разработчика
defaults write com.google.Chrome DeveloperToolsEnabled -bool true
# Disable download warnings
# Отключить предупреждения о загрузках
defaults write com.google.Chrome DownloadWarningsEnabled -bool false
# Disable auto-updates
# Отключить автоматическое обновление
defaults write com.google.Chrome DisableAutoUpdate -bool true
# Disable hardware acceleration
# Отключить аппаратное ускорение
defaults write com.google.Chrome HardwareAccelerationModeEnabled -bool false
killall "Google Chrome"


# Configure Finder preferences
# Настройка Finder
echo "Configuring Finder..."
# Open new Finder windows in the home directory
# Открывать новые окна Finder в домашней директории
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Disable animations when opening and closing windows
# Отключить анимацию открытия и закрытия окон
defaults write com.apple.finder DisableAllAnimations -bool true
# Set the default search scope to the current folder
# Установить область поиска по умолчанию — текущая папка
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Enable the "Quit" option in Finder's menu
# Добавление опции "Выйти" в меню Finder
defaults write com.apple.finder QuitMenuItem -bool true
# Group items by kind in Finder
# Группировка элементов по типу в Finder
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"
# Show the status bar and path bar
# Показать строку состояния и путь в Finder
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
# Sort folders first in Finder views
# Сортировать папки первыми в представлениях Finder
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
# Show drives and removable media on desktop
# Показывать диски и сменные носители на рабочем столе
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Configure desktop view settings
# Настройка отображения на рабочем столе
defaults write com.apple.finder DesktopViewSettings -dict-add IconViewSettings -dict \
    iconSize -int 76 \
    gridSpacing -int 54 \
    textSize -int 11 \
    showItemInfo -bool true \
    showIconPreview -bool true
# Configure list view settings for sorting by name
# Настройка представления списка для сортировки по имени
defaults write com.apple.finder FK_DefaultListViewSettings -dict-add sortColumn -string "name"
# Disable relative dates in list view and set text size
# Отключить относительные даты в представлении списка и установить размер текста
defaults write com.apple.finder StandardViewSettings -dict-add ListViewSettings -dict \
    useRelativeDates -bool false \
    textSize -int 13
# Set text size for icon view
# Установить размер текста для представления значков
defaults write com.apple.finder StandardViewOptions -dict-add IconViewSettings -dict textSize -int 12
# Show hidden files in Finder
# Отображение скрытых файлов в Finder
echo "Displaying hidden files in Finder..."
defaults write com.apple.Finder AppleShowAllFiles true
# Show all file extensions in Finder
# Показывать все расширения файлов в Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Restart Finder to apply changes
# Перезапуск Finder для применения изменений
killall Finder

echo "Finder configuration complete."


# Configure Dock preferences
# Настройка Dock
echo "Configuring Dock..."
# Remove the auto-hide delay for the Dock
# This makes the Dock appear instantly when moving the cursor to its position.
# Это позволяет Dock появляться мгновенно при наведении курсора.
defaults write com.apple.Dock autohide-delay -float 0
# Dim icons of hidden applications in the Dock
# This makes the icons of hidden applications appear semi-transparent.
# Это делает значки скрытых приложений полупрозрачными.
defaults write com.apple.Dock showhidden -bool true
# Set Dock orientation to the left side of the screen
# Установить Dock слева на экране
defaults write com.apple.dock orientation -string "left"
# Enable magnification and set the size of magnified icons
# Включить увеличение и задать размер увеличенных значков
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 74
# Minimize windows into their application icon
# Минимизировать окна в значок приложения
defaults write com.apple.dock minimize-to-application -bool true
# Automatically hide and show the Dock
# Автоматически скрывать и показывать Dock
defaults write com.apple.dock autohide -bool true
# Group windows by application in Mission Control
# Группировать окна по приложениям в Mission Control
defaults write com.apple.dock expose-group-apps -bool true
# Disable showing recent applications in the Dock
# Отключить отображение недавних приложений в Dock
defaults write com.apple.dock show-recents -bool false
# Show the "trash full" indicator in the Dock
# Отображать индикатор "мусорная корзина заполнена" в Dock
defaults write com.apple.dock trash-full -bool true
# Set the size of Dock icons
# Установить размер значков Dock
defaults write com.apple.dock tilesize -int 28
# Disable Dock bouncing on app launch
# Отключить подпрыгивание значков приложений при запуске
defaults write com.apple.dock no-bouncing -bool true
# This allows using a specific gesture to view all open windows of the active application.
# Это позволяет использовать специальный жест для отображения всех открытых окон активного приложения.
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Speed up Mission Control animations
# Ускорить анимацию Mission Control
# defaults read com.apple.dock expose-animation-duration -float 0.1

# Restart Dock to apply changes
# Перезапустить Dock для применения изменений
killall Dock
echo "Dock configuration complete."

# Set the location for screenshots
# Установить место для сохранения снимков экрана
echo "Configuring screenshot location..."
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

killall SystemUIServer
echo "Screenshot location configured."

# Additional
# ======================
# Uncomment and add these lines if relevant:
# Enable key repeat instead of press-and-hold for characters
# Включить повтор символов вместо удержания для ввода специальных символов
# defaults write -g ApplePressAndHoldEnabled -bool false


# Avoid creating .DS_Store files on network or USB volumes
# Не создавать файлы .DS_Store на сетевых или USB-носителях
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Automatically quit the printer app once print jobs complete
# Автоматически завершать приложение принтера после выполнения заданий
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Require password immediately after sleep or screen saver begins
# Требовать пароль сразу после сна или запуска заставки
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Отключить отчёт о сбоях (Crash Reporter)
# Этот параметр отключает появление диалогового окна при сбоях системы.
# defaults write com.apple.CrashReporter DialogType -string "none"

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "ru"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Show language menu in the top right corner of the boot screen
# Это полезно, если нужно выбрать раскладку клавиатуры или язык на экране входа.
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true


echo "System configuration complete. Please log out or restart to ensure all changes take effect."

# Install Homebrew (if not already installed)
# Установка Homebrew (если ещё не установлен)
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Install packages from Brewfile
# Установка пакетов из Brewfile
if [ -f "./Brewfile" ]; then
  echo "Installing Homebrew packages from Brewfile..."
  brew bundle --file=./Brewfile
  echo "Installation complete."
else
  echo "Brewfile not found. Skipping package installation."
fi