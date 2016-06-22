###############################################################################
## PACKAGES
%packages

# Defaults
# Exclude unwanted groups that fedora-live-base.ks pulls in
-@dial-up
-@input-methods
-@printing
-@standard
-@multimedia

# Exclude unwanted packages from @anaconda-tools group
-gfs2-utils
-reiserfs-utils

# Branding
-fedora-release-workstation
-fedora-user-agent-chrome
-fedora-logos
-fedora-release
-fedora-release-notes
-fedora-productimg-workstation # Installer branding.
generic-release
generic-logos
generic-release-notes

# My preferred apps
#@^developer-workstation-environment

@3D Printing
@admin-tools
@critical-path-gnome
-@Fedora Eclipse
-@Fedora Packager
@firefox
-@Haskell
-@Java Application Server
-@Java Development
-@KDE Frameworks 5 Software Development
-@KDE Software Development
-@Legacy Software Development
@libreoffice
-@MariaDB (MySQL) Database
-@Milkymist
-@MongoDB
@networkmanager-submodules
-@OCaml
@Python
-@workstation-product
-@X Software Development

arduino						# Arduino programming.
audacity 					# Audio editor.
-blender
devassistant				# Making life easier for developers.
ditaa 						# Diagrams Through ASCII Art
dokuwiki 					# Standards compliant simple to use wiki.
conky						# A system monitor for X.
dia 						# Diagraming.
dconf-editor
eclipse
epiphany 					# Web browser for GNOME
#electric					# Circuit CAD
#fedy						# Gnome tweaks.
fritzing					# Create a PCB layout for manufacturing.
gitg						# GNOME GUI client to view git repositories.
gnome-tweak-tool			# Gnome tweaks.
gnucap						# Circuit simulator.
gpick 						# Color picker.
gresistor					# Gnome resistor color code calculator.
gtkterm
#handbrake-gui				# Multiplatform video transcoder (GUI)
#handbrake-cli				# Multiplatform video transcoder (CLI)
icaro						# Robotic Educational Project.
inkscape					# Vector graphics drawing.
#luckybackup 				# A powerful, fast and reliable backup and sync tool.
magic						# Circuit layout.
magic-doc
meld						# Visual diff and merge tool.
minicom
opencv
openscad					# CAD
pencil						# UI design.
redshift					# Screen ergonomics.
screenruler 				# Measure things using your screen.
python-sphinx        		# Python documentation generator.
python-sphinx-doc 			# Documentation for python-sphinx
python-sphinx-theme-better	# A Better Sphinx Theme.
tmux 						# A terminal multiplexer.
tmux-powerline 				# Powerline for tmux.
tmuxinator-doc 				# Documentation for tmuxinator.
tmuxinator 					# Create and manage complex tmux sessions easily.
vim  						# The VIM editor.
vim-powerline				# Powerline VIM plugin.
#vlc						# Multimedia framework, player and server.
xournal						# Journaling app.

#sublimetext

%end

###############################################################################
## POST - NOCHROOT
%post --nochroot

printf "%s\n" "#######################################"
printf "%s\n" "# Beginning post --nochroot."
printf "%s\n\n" "#######################################"

printf "%s\n" "-------------------------------------------------------------------------------"
printf "%s\n" "Fixing laptop suspend."
sed -i -e 's/#HandleLidSwitch=suspend/HandleLidSwitch=suspend/g' $INSTALL_ROOT/etc/systemd/logind.conf
printf "Return: %s\n" $?
sed -i -e 's/#HandleSuspendKey=suspend/HandleSuspendKey=suspend/g' $INSTALL_ROOT/etc/systemd/logind.conf
printf "Return: %s\n" $?

printf "%s\n" "-------------------------------------------------------------------------------"
printf "%s\n" "Dumping current variables to /tmp/variables.after"
( set -o posix ; set ) >docs/variables.after
printf "Return: %s\n" $?

printf "%s\n" "-------------------------------------------------------------------------------"
printf "%s\n" "Running sed to update release and issue info."
sed -i -e 's/Generic release/Tananda Remix/g' /etc/fedora-release /etc/issue
printf "Return: %s\n" $?

# ##### START METHOD 1 FOR SETTING GNOME BACKGROUND #####
# # Copy wallpaper into place.
# printf "%s\n" "-------------------------------------------------------------------------------"
# printf "%s\n" "Installing wallpaper."
# install -Dv files/Sepik.jpg $INSTALL_ROOT/usr/share/backgrounds/tananda/Sepik.jpg
# #install -Dv files/Sepik.jpg $LIVE_ROOT/usr/share/backgrounds/tananda/Sepik.jpg
# printf "Return: %s\n" $?

# printf "%s\n" "-------------------------------------------------------------------------------"
# printf "Install install_root wallpaper with gsettings."
# #dbus-launch gsettings set org.gnome.desktop.background picture-uri file://$LIVE_ROOT/usr/share/backgrounds/tananda/Sepik.jpg
# dbus-launch gsettings set org.gnome.desktop.background picture-uri file://$INSTALL_ROOT/usr/share/backgrounds/tananda/Sepik.jpg
# printf "path: %s\n" "file://$INSTALL_ROOT/usr/share/backgrounds/tananda/Sepik.jpg"
# printf "\n"
# printf "Return: %s\n" $?
# # ##### END METHOD 1 FOR SETTING GNOME BACKGROUND #####

##### START METHOD 2 FOR SETTING GNOME BACKGROUND #####
# # Copy wallpaper into place.
# printf "%s\n" "-------------------------------------------------------------------------------"
# printf "%s\n" "Installing wallpaper."
# install -Dv files/Sepik.jpg $INSTALL_ROOT/usr/share/backgrounds/tananda/Sepik.jpg
# install -Dv files/Sepik.jpg $LIVE_ROOT/usr/share/backgrounds/tananda/Sepik.jpg
# printf "Return: %s\n" $?

# # Install database entry for background.
# printf "%s\n" "-------------------------------------------------------------------------------"
# printf "%s\n" "Install database entry for background."
# install -Dv files/01-background $INSTALL_ROOT/etc/dconf/db/local.d/01-background
# install -Dv files/01-background $LIVE_ROOT/etc/dconf/db/local.d/01-background
# printf "Return: %s\n\n" $?

# printf "%s\n" "-------------------------------------------------------------------------------"
# printf "%s\n" "Running dconf update."
# dconf update
# printf "Return: %s\n\n" $?
##### END METHOD 2 FOR SETTING GNOME BACKGROUND #####

printf "\n"
printf "%s\n" "#######################################"
printf "%s\n" "# End post --nochroot."
printf "%s\n\n" "#######################################"

%end

# ###############################################################################
# ## POST : Install Sublime Text 3
# %post
# #!/bin/sh

# # Sublime Text 3 install with Package Control
# # based on http://simonewebdesign.it/blog/install-sublime-text-3-on-fedora-20/

# ST3URL="http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3083_x64.tar.bz2"
# PCURL="https://sublime.wbond.net/Package%20Control.sublime-package"

# curl -o ~/st3.tar.bz2 $ST3URL
# if tar -xf ~/st3.tar.bz2 --directory=$HOME; then
#   sudo mv ~/sublime_text_3/ /opt/
#   sudo ln -s /opt/sublime_text_3/sublime_text /bin/subl
# fi
# rm ~/st3.tar.bz2

# # Package Control - The Sublime Text Package Manager: https://sublime.wbond.net
# curl -o ~/Package\ Control.sublime-package $PCURL
# sudo mv ~/Package\ Control.sublime-package /opt/sublime_text_3/Packages/

# # Add to applications list
# cat << EOF > ~/.local/share/applications/sublime.desktop
# [Desktop Entry]
# Name=Sublime Text
# Exec=subl %F
# MimeType=text/plain;
# Terminal=false
# Type=Application
# Icon=/opt/sublime_text_3/Icon/128x128/sublime-text.png
# Categories=Utility;TextEditor;Development;
# EOF

# echo ""
# echo "Sublime Text 3 installed successfully!"
# echo "Run with: subl"

# %end
