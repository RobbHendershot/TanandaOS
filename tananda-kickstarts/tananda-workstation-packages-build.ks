#version=DEVEL

# System bootloader configuration
bootloader --location=none

%packages
@base-x
@core
@firefox
@fonts
@guest-desktop-agents
@hardware-support
@libreoffice
@multimedia
@networkmanager-submodules
@printing
@workstation-product
fedora-productimg-workstation
-@dial-up
-@dial-up
-@input-methods
-@input-methods
-@standard
-@standard
-gfs2-utils
-reiserfs-utils

%end
