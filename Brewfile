# http://sourabhbajaj.com/mac-setup/

# Make sure we’re using the latest Homebrew
'update'
# Upgrade any already-installed formulae
'upgrade'


tap "caskroom/cask"
tap "caskroom/versions"
tap "homebrew/bundle"
tap "homebrew/completions"
tap "homebrew/core"
tap "homebrew/dupes"
tap "homebrew/services"
tap "swiftkit/cuckoo"

tap "homebrew/cask"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "homebrew/services"

cask_args appdir: '/Volumes/data/Applications'

# brew cask list --versions

# Create a Brewfile from all the existing Homebrew packages you have installed with
# brew bundle dump

# You can also use Brewfile as a whitelist.
# It's useful for maintainers/testers who regularly install lots of formulae.
# To uninstall all Homebrew formulae not listed in Brewfile:
# brew bundle cleanup

# install packages
brew "afl-fuzz"     # American fuzzy lop is a security-oriented fuzzer that employs a novel
					# type of compile-time instrumentation and genetic algorithms to automatically discover clean, interesting test cases that trigger new internal states in the targeted binary
					# http://lcamtuf.coredump.cx/afl/


brew "openssl"
brew "openssl@1.1"

brew "libressl"     # LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.
					# https://www.libressl.org


########################
# Network tools, vulnerability-analysis
brew "aircrack-ng"  # Aircrack-ng is a complete suite of tools to assess WiFi network security.
					# https://www.aircrack-ng.org

brew "arp-scan"     # command-line tool that uses the ARP protocol to discover
					# and fingerprint IP hosts on the local network
					# https://github.com/royhills/arp-scan

brew "arp-sk"       # ARP traffic generation tool designed to manipulate ARP tables of all kinds of equipment.
					# This can be easily performed through the sending of the appropriate packet(s).
					# http://sid.rstack.org/arp-sk/

brew "arping"       # Arping is a util to find out if a specific IP address on the LAN is 'taken' and what MAC address owns it.
					# Broadcasts a who-has ARP packet on the network and prints answers. VERY useful when you are trying to pick an unused IP for a net that you don't yet have routing to.
					# https://github.com/ThomasHabets/arping

brew "spoof-mac"    # Change your MAC address for debugging
					# https://github.com/feross/SpoofMAC

brew "bittwist"     # Bit-Twist is a simple yet powerful libpcap-based Ethernet packet generator.
					# It is designed to complement tcpdump, which by itself has done a great job at capturing network traffic.
					# http://bittwist.sourceforge.net

brew "dsocks"       # SOCKS client wrapper for *BSD / MacOS X.
					# https://monkey.org/~dugsong/dsocks/

brew "nmap"         # Nmap ("Network Mapper") is a free and open source (license) utility for network discovery and security auditing.
					# https://nmap.org

brew "proxychains-ng"   # proxychains is a hook preloader that allows to redirect TCP traffic of existing
						# dynamically linked programs through one or more SOCKS or HTTP proxies.
						# https://sourceforge.net/projects/proxychains-ng/

brew "privoxy", restart_service: :changed    # Privoxy is a non-caching web proxy with advanced filtering capabilities
											# for enhancing privacy, modifying web page data and HTTP headers, controlling access, and removing ads and other obnoxious Internet junk.
											# https://www.privoxy.org


brew "tor", restart_service: :changed    # Tor is free software and an open network that helps you defend against
										# traffic analysis, a form of network surveillance that threatens personal freedom and privacy, confidential business activities and relationships, and state security.
										# https://www.torproject.org

brew "torsocks"     # Wrapper to safely torify applications
					# https://gitweb.torproject.org/torsocks.git/

brew "c-ares"       # c-ares is a C library for asynchronous DNS requests (including name resolves)
					# https://c-ares.haxx.se

brew "socat"        # Multipurpose relay
					# http://www.dest-unreach.org/socat/

brew "speedtest_cli"    # Command line interface for testing internet bandwidth using speedtest.net
						# https://github.com/sivel/speedtest-cli

brew "testssl"      # testssl.sh is a free command line tool which checks a server's service on any port
					# for the support of TLS/SSL ciphers, protocols as well as recent cryptographic flaws and more
					# https://testssl.sh

brew "sslscan"      # sslscan tests SSL/TLS enabled services to discover supported cipher suites
					# https://github.com/rbsec/sslscan

########################
# Developer tools
brew "llvm", args: ['--with-clang']
brew "appledoc"     # appledoc is command line tool that helps Objective-C developers generate
					# Apple-like source code documentation from specially formatted source code comments
					# https://github.com/tomaz/appledoc

brew "libsodium"    # A modern and easy-to-use crypto library.
					# https://github.com/jedisct1/libsodium/
					# https://download.libsodium.org/doc/

brew "mbedtls"      # mbed TLS (formerly known as PolarSSL) makes it trivially easy for developers
					# to include cryptographic and SSL/TLS capabilities in their (embedded) products,
					# facilitating this functionality with a minimal coding footprint
					# https://tls.mbed.org

brew "ios-deploy"   # Install and debug iPhone apps from the command line, without using Xcode
					# https://github.com/phonegap/ios-deploy


########################
# Reverse tools
brew "capstone"     # Capstone is a lightweight multi-platform, multi-architecture disassembly framework.
					# http://www.capstone-engine.org






brew "arss"         # The Analysis & Resynthesis Sound Spectrograph (formerly known as the
					# Analysis & Reconstruction Sound Engine), or ARSS, is a program that analyses a sound file into
					# a spectrogram and is able to synthesise this spectrogram, or any other user-created image, back into a sound.
					# http://arss.sourceforge.net

brew "calc"         # Calc - C-style arbitrary precision calculator
					# http://www.isthe.com/chongo/tech/comp/calc/

brew "cask"         # Cask is a project management tool for Emacs Lisp to automate the package development cycle;
					# development, dependencies, testing, building, packaging and more.
					# https://cask.readthedocs.io/en/latest/

brew "ccrypt"       # ccrypt is a utility for encrypting and decrypting files and streams.
					# It was designed as a replacement for the standard unix crypt utility, which is notorious for using a very weak encryption algorithm.
					# ccrypt is based on the Rijndael block cipher, a version of which is also used in the Advanced Encryption Standar
					# http://ccrypt.sourceforge.net

brew "ctags"        # Ctags generates an index (or tag) file of language objects found in source files
					# that allows these items to be quickly and easily located by a text editor or other utility.
					# http://ctags.sourceforge.net

brew "wget"         # download stuff from the web, easier to use than curl.
					# GNU Wget is a free software package for retrieving files using HTTP, HTTPS and FTP,
					# the most widely-used Internet protocols.
					# It is a non-interactive commandline tool, so it may easily be called from scripts, cron jobs, terminals without X-Windows support, etc.
					# https://www.gnu.org/software/wget/

brew "crosstool-ng" # Crosstool-NG is a versatile (cross) toolchain generator.
					# It supports many architectures and components and has a simple yet powerful menuconfig-style interface.
					# http://crosstool-ng.github.io

########################
## Android

brew "apktool"      # A tool for reverse engineering Android apk files
					# https://ibotpeaches.github.io/Apktool/
					# https://github.com/iBotPeaches/Apktool

brew "dex2jar"      # Tools to work with android .dex and java .class files
					# https://github.com/pxb1988/dex2jar

brew "jasmin"       # Jasmin is an assembler for the Java Virtual Machine.
					# It takes ASCII descriptions of Java classes, written in a simple assembler-like
					# syntax using the Java Virtual Machine instruction set. It converts them into binary Java class files, suitable for loading by a Java runtime system.
					# http://jasmin.sourceforge.net




brew "coreutils"
brew "findutils"
brew "moreutils"

brew "geoip"        # GeoIP Legacy C API
					# This library is for the GeoIP Legacy format (dat). To read the MaxMind DB format (mmdb) used by GeoIP2, please see libmaxminddb.
					# https://github.com/maxmind/geoip-api-c

brew "gnupg"
brew "highlight"    # Highlight converts sourcecode to HTML, XHTML, RTF, LaTeX, TeX, SVG,
					# BBCode and terminal escape sequences
					# with coloured syntax highlighting. Language definitions and colour themes are customizable
					# http://www.andre-simon.de/doku/highlight/en/highlight.php

brew "htop"

brew "imessage-ruby"
brew "ldid"

brew "libimobiledevice"	# libimobiledevice is a cross-platform software library that talks the protocols to support
						# iPhone®, iPod Touch®, iPad® and Apple TV® devices
						# http://www.libimobiledevice.org



brew "mobiledevice"     # Command line utility for interacting with Apple's Private (Closed) Mobile Device Framework
						# https://github.com/imkira/mobiledevice



brew "nano"

brew "node"
brew "ntfs-3g"
brew "p7zip"

brew "python"
brew "python2"
brew "python3"


########################
## Databases
brew "sqlmap"			# an open source penetration testing tool that automates the process of detecting and
						# exploiting SQL injection flaws and taking over of database servers
						# http://sqlmap.org

brew "sqlite"
brew "mysql", restart_service: :changed
brew "postgresql", restart_service: :changed
brew "redis", restart_service: :changed
# redis-server /usr/local/etc/redis.conf



brew "qemu"         # QEMU is a generic and open source machine emulator and virtualizer.
					# https://www.qemu.org

brew "radare2"      # Radare is a portable reversing framework that can disassemble (and assemble for)
					# many different architectures
					# https://radare.org/r/

brew "capstone"     # Capstone is a lightweight multi-platform, multi-architecture disassembly framework.
					# http://www.capstone-engine.org



brew "gnu-sed", args: ["--with-default-names"]
brew "zsh"
brew "vim", args: ["--override-system-vi"]
brew "macvim"
brew "grep"
brew "openssh"
brew "screen"

brew "ack"          # tool like grep, optimized for programmers
					# https://beyondgrep.com

brew "dark-mode"
brew "git"
brew "git-lfs"		# Git extension for versioning large files
brew "p7zip"		# 7-Zip (high compression file archiver) implementation
brew "rename"
brew "ssh-copy-id"	# Add a public key to a remote machine's authorized_keys file


brew "tree"             # Tree is a recursive directory listing command that produces a depth indented listing of files.
						# ascii art of directories, subdirs, and files
brew "pandoc"           # If you need to convert files from one markup format into another,
						# pandoc is your swiss-army knife.
						# Pandoc can convert documents in markdown, reStructuredText, textile, HTML, DocBook, LaTeX, MediaWiki markup, TWiki markup, OPML, Emacs Org-Mode, Txt2Tags, Microsoft Word docx, LibreOffice ODT, EPUB, or Haddock markup
brew "imagemagick"      # Tools and libraries to manipulate images in many formats. use the 'convert' command to edit/convert images and pdfs

########################
## Ruby
brew "rbenv"
brew "ruby-build"
brew "rbenv-default-gems"
brew "rbenv-gemset"


brew "youtube-dl"
brew "trash"			# CLI tool that moves files or folder to the trash
brew "tmux"				# Terminal multiplexer
brew "htop"
brew "watch"            # re display results from a command every x seconds

brew "opencv"			# Open source computer vision library

brew "adns"				# C/C++ resolver library and DNS resolver utilities
brew "appledoc"			# Objective-C API documentation generator
brew "arss"				# Analyze a sound file into a spectrogram

brew "autoconf"
brew "automake"
brew "bash"
brew "bash-completion"	# Programmable completion for Bash 3.2

brew "binutils"
brew "bittwist"			# Libcap-based Ethernet packet generator
brew "boost"
brew "calc"

# brew "carthage"   # A simple, decentralized dependency manager for Cocoa
					# https://github.com/Carthage/Carthage

# brew "alcatraz"

brew "fabric"       # Fabric is a Python (2.5-2.7) library and command-line tool
					# for streamlining the use of SSH for application deployment or systems administration tasks.
					# http://www.fabfile.org



brew "cmake"
# brew "corelocationcli"
brew "dirmngr"
brew "dos2unix"
brew "dpkg"
brew "emacs"
brew "exiftool"
brew "exploitdb"

brew "ffmpeg", args: ['--with-fdk-aac', '--with-ffplay', '--with-freetype', '--with-libass', '--with-libvorbis', '--with-libvpx', '--with-opus', '--with-x265'] # convert video files

brew "fftw"         # FFTW is a C subroutine library for computing the discrete Fourier transform (DFT)
					# in one or more dimensions, of arbitrary input size, and of both real and complex data (as well as of even/odd data, i.e. the discrete cosine/sine transforms or DCT/DST).
					# http://www.fftw.org

brew "gawk"
brew "gdbm"
brew "gettext"

# Install GIT
brew "git"


brew "glib"
brew "gmp"
brew "gnu-sed"
brew "gnu-tar"


########################
## Cryptography
brew "gnupg"
brew "gnupg2"
brew "libgcrypt"        # Cryptographic library
						# https://directory.fsf.org/wiki/Libgcrypt

brew "libgpg-error"
brew "libksba"       	#
						# https://www.gnupg.org/related_software/libksba/

brew "libtasn1"     	# Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.
						# It was written by Fabio Fiorina, and has been shipped as part of GnuTLS for some time but is now a proper GNU package.
						# https://www.gnu.org/software/libtasn1/



brew "gnutls"
brew "gpatch"

brew "gpg-agent"
brew "icu4c"
brew "imessage-ruby"
brew "jpeg"
brew "lame"
brew "ldid"
brew "libassuan"
brew "libelf"
brew "libevent"
brew "libewf"
brew "libffi"
brew "unrar"

brew "hashcat"      # World's fastest password cracker
					# https://hashcat.net/hashcat/
					# http://tuukkamerilainen.com/how-to-crack-macbook-admin-password/
					# https://www.unix-ninja.com/p/Exploiting_masks_in_Hashcat_for_fun_and_profit
					# https://hashcat.net/wiki/doku.php?id=oclhashcat
					# https://web.archive.org/web/20140703020831/http://www.michaelfairley.co/blog/2014/05/18/how-to-extract-os-x-mavericks-password-hash-for-cracking-with-hashcat/

brew "libmagic"     #
					# https://www.darwinsys.com/file/

brew "libnet"       # libnet provides a portable framework for low-level network packet construction.
					# https://github.com/sam-github/libnet

brew "libpng"       # libpng is the official PNG reference library.
					# http://www.libpng.org/pub/png/libpng.html

brew "libunistring" # libunistring is also for you if your application uses Unicode
					# strings as internal in-memory representation
					# https://www.gnu.org/software/libunistring/

brew "libusb"       # libusb is a C library that provides generic access to USB devices.
					# It is intended to be used by developers to facilitate the production of applications that communicate with USB hardware
					# http://libusb.info

brew "libusb-compat"

brew "lua"          # Lua is a powerful, efficient, lightweight, embeddable scripting language.
					# https://www.lua.org

brew "mpfr"         # The MPFR library is a C library for multiple-precision floating-point
					# computations with correct rounding.
					# http://www.mpfr.org

brew "nano"         # GNU nano is designed to be a free replacement for the Pico text editor,
					# part of the Pine email suite from The University of Washington.
					# https://www.nano-editor.org

brew "ncurses"      # The ncurses (new curses) library is a free software emulation of curses
					# in System V Release 4.0 (SVr4), and more.
					# https://www.gnu.org/software/ncurses/

brew "nettle"       # Nettle is a cryptographic library that is designed to fit easily in more or less any context:
					# In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.
					# https://www.lysator.liu.se/~nisse/nettle/

brew "node"         # Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.
					# https://nodejs.org/en/

brew "npth"         # The New GNU Portable Threads Library.
					# https://gnupg.org/software/libraries.html

brew "ntfs-3g"      # NTFS-3G is a stable, full-featured, read-write NTFS driver for Linux,
					# Android, Mac OS X, FreeBSD, NetBSD, OpenSolaris,
					# QNX, Haiku, and other operating systems. It provides safe handling of the Windows XP, Windows Server 2003, Windows 2000,
					# Windows Vista, Windows Server 2008, Windows 7, Windows 8 and Windows 10 NTFS file systems.
					# A high-performance alternative, called Tuxera NTFS is available for embedded devices and Mac OS X: http://www.tuxera.com/products/tuxera-ntfs-for-mac/
					# https://www.tuxera.com/community/open-source-ntfs-3g/

brew "p11-kit"      # This is an effort to use and promote PKCS#11 as glue between crypto
					# libraries and security applications on the open source desktop.
					# https://p11-glue.freedesktop.org

brew "p7zip"		# p7zip is a port of 7za.exe for POSIX systems like Unix (Linux, Solaris,
					# OpenBSD, FreeBSD, Cygwin, AIX, ...), MacOS X and also for BeOS and Amiga.
					# http://p7zip.sourceforge.net

brew "pcre"         # The PCRE library is a set of functions that implement regular expression
					# pattern matching using the same syntax and semantics as Perl 5.
					# http://www.pcre.org

brew "pinentry"     # pinentry is a small collection of dialog programs that allow GnuPG to read
					# passphrases and PIN numbers in a secure manner.
					# There are versions for the common GTK and Qt toolkits as well as for the text terminal (Curses).
					# https://www.gnupg.org/related_software/pinentry/

brew "pixman"       # Cairo is a 2D graphics library with support for multiple output devices.
					# Currently supported output targets include the X Window System (via both Xlib and XCB), Quartz, Win32, image buffers, PostScript, PDF, and SVG file output.
					# Experimental backends include OpenGL, BeOS, OS/2, and DirectFB.
					# https://cairographics.org

brew "cairo"		# Vector graphics library with cross-device output support

brew "pkg-config"   # pkg-config is a helper tool used when compiling applications and libraries.
					# It helps you insert the correct
					# compiler options on the command line so an application can use gcc -o test test.c `pkg-config --libs --cflags glib-2.0`
					# for instance, rather than hard-coding values on where to find glib (or other libraries).
					# It is language-agnostic, so it can be used for defining the location of documentation tools, for instance.
					# https://freedesktop.org/wiki/Software/pkg-config/

brew "readline"     # The GNU Readline library provides a set of functions for use by applications
					# that allow users to edit command lines as they are typed in.
					# https://tiswww.case.edu/php/chet/readline/rltop.html

brew "sphinx-doc"   # Sphinx is a tool that makes it easy to create intelligent and beautiful documentation,
					# written by Georg Brandl and licensed under the BSD license.
					# http://www.sphinx-doc.org/en/stable/

brew "x264"         # x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format
						# https://www.videolan.org/developers/x264.html

brew "xvid"         # High-performance, high-quality MPEG-4 video library. The free video codec that's strong in compression and quality. Number one choice of millions worldwide.
						# https://www.xvid.com

brew "xz"           # xz is a command line tool with syntax similar to that of gzip
					# https://tukaani.org/xz/

brew "yara"         # YARA is a tool aimed at (but not limited to) helping malware researchers
					# to identify and classify malware samples.
					# https://github.com/VirusTotal/yara/

brew "webp"			# Image format providing lossless and lossy compression for web images

# cp /usr/local/etc/privoxy/config /usr/local/opt/privoxy/sbin/
# cp /usr/local/Cellar/config /usr/local/opt/privoxy/sbin/
# // add this following line into config file, it means forward filtered data to Tor.
# forward-socks4a / 127.0.0.1:9050 .

brew "tesseract"	# OCR (Optical Character Recognition) engine

brew "pth"          # Pth is a very portable POSIX/ANSI-C based library for Unix platforms which provides non-preemptive priority-based scheduling for multiple threads of execution (aka ``multithreading'') inside event-driven applications. All threads run in the same address space of the server application, but each thread has it's own individual program-counter, run-time stack, signal mask and errno variable.
					# https://www.gnu.org/software/pth/

brew "unbound"		# Validating, recursive, caching DNS resolver

brew "gdrive"       # Google Drive CLI Client
					# https://github.com/prasmussen/gdrive

brew "flac"			# Free lossless audio codec

## Android
brew "ant"
brew "maven"
brew "gradle"

# Remove outdated versions from the cellar
'cleanup'
