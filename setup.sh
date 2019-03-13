#!/usr/bin/env sh

RED='\033[00;31m'
GREEN='\033[00;32m'
CYAN='\033[00;36m'
RESET='\033[0m'

# Project based on:
# https://github.com/sidaf/dotfiles
# https://github.com/sidaf/homebrew-pentest
# https://github.com/cowboy/dotfiles

# https://minhoryang.github.io/en/posts/gardeninggrooming-os-x-for-developer/
# https://github.com/mathiasbynens/dotfiles
# https://github.com/michalzelinka/dotfiles
# https://github.com/necolas/dotfiles
# http://anthonyramella.com/blog/awesome-bash-profile/
# https://github.com/trevordmiller/shell-scripts
#
#
#
# TODO:
#   editorconfig.org!
#   https://github.com/mas-cli/mas ?????

# Shell scripts for automated macOS machine setup.


echo Install all AppStore Apps at first!
# no solution to automate AppStore installs
read -p "Press any key to continue... " -n1 -s
echo  '\n'

# Install Xcode Command Line Tools
xcode-select --install

# Agree to the XCode license
sudo xcodebuild -license

# ========= Brew ==========
# if ! type "brew" > /dev/null; then
if [[ -z $(command -v brew) ]]; then
    echo "${RED}Install Homebrew, Postgres, wget and cask${RESET}"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "${GREEN}Homebrew already installed, skipping installation${RESET}"
fi

echo ""

# Config git
git config --global user.name "Your Name"
git config --global user.email "your_email@domain.com"
# configure git to store your password
git config --global credential.helper osxkeychain


# Development
echo Install Dev Apps
brew cask install --appdir="/Applications" github


# Nice to have
echo Install Some additional Apps
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" skype


## Tor and Privoxy
brew install tor

# defaults write /usr/local/opt/tor/homebrew.mxcl.tor.plist ProgramArguments -array-add '{-f;/usr/local/etc/tor/torrc}'
# To have launchd start tor at login:
ln -sfv /usr/local/opt/tor/homebrew.mxcl.tor.plist ~/Library/LaunchAgents
# Then to load tor now:
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.tor.plist

brew install torsocks
brew install privoxy

# cp /usr/local/etc/privoxy/config /usr/local/opt/privoxy/sbin/
# cp /usr/local/Cellar/config /usr/local/opt/privoxy/sbin/
# // add this following line into config file, it means forward filtered data to Tor.
# forward-socks4a / 127.0.0.1:9050 .


brew install proxychains-ng
brew install pth

brew install python2
pip install --upgrade pip setuptools
pip install virtualenv
pip install virtualenvwrapper

pip install Flask
# http://flask.pocoo.org
# FLASK_APP=hello.py flask run
# Running on http://localhost:5000/


# SciPy (pronounced “Sigh Pie”) is a Python-based ecosystem of open-source software for mathematics, science, and engineering.
pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose



# Install tools
brew bundle Brewfile

