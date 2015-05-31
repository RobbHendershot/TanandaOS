%packages
#@firefox
@critical-path-gnome

#@3d-printing
cura
openscad
slic3r

@admin-tools
conky-manager
conky

#@authoring-and-publishing
pandoc
python-docutils
python-sphinx
python-pip

#@design-suite
inkscape

#@development-tools
-python3
git

#@editors
vim-enhanced
vim-X11

#@eclipse
eclipse
eclipse-egit
eclipse-epic
eclipse-pydev

#@graphical-internet

#@graphics

#@multimedia

#@office
Zim

#@online-docs

#@perl
vim-perl-support

#@robotics-suite
arduino

#@security-lab
aircrack-ng
arp-scan
nmap
wireshark-gnome

@system-tools
gnome-tweak-tool
gnome-shell-extension-user-theme
gnome-shell-extension-apps-menu

#virtualbox
@virtualization

#vagrant

# Needed to make Gnome Online Accounts work
telepathy-haze

# Remove featured apps.
-transmission-gtk
-simple-scan
-gnome-photos
-gnome-maps
-gnome-weather

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @standard
-smartmontools

# We use gnome-control-center's printer and input sources panels instead
-system-config-printer
-im-chooser

# Similarly, there was also some debate about removing rsyslog from @standard
# (since much of its functionality is provided by journald now), but it's
# not going to happen for f20 either, so drop it here for now.
# https://lists.fedoraproject.org/pipermail/devel/2013-July/186796.html
-rsyslog
%end
