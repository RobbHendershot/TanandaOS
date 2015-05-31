%packages

@base-x
@core
@fonts
@guest-desktop-agents
@hardware-support
@libreoffice
@multimedia
@networkmanager-submodules
@printing
@workstation-product
@critical-path-gnome
@admin-tools
@system-tools
@virtualization
-@dial-up
-@fedora-release-nonproduct
-@input-methods
-@standard
-@firefox

fedora-productimg-workstation # Branding for the installer

google-chrome-stable
cura
openscad
slic3r
conky-manager
conky
pandoc
python-docutils
python-sphinx
python-pip
inkscape
git
vim-enhanced
vim-X11
livecd-tools
fritzing

eclipse
eclipse-egit
eclipse-epic
eclipse-pydev

Zim
vim-perl-support
arduino
aircrack-ng
arp-scan
nmap
wireshark-gnome

gnome-tweak-tool
gnome-shell-extension-user-theme
gnome-shell-extension-apps-menu

telepathy-haze # Needed to make Gnome Online Accounts work

zsh
byobu

# Exclude unwanted packages from @anaconda-tools group
-gfs2-utils
-reiserfs-utils

-python3


%end
