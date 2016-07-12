Description
===========
"A Fedora Remix is a combination of Fedora software, with or without third-party software,
that any community member can create at any time..."

Instructions
============
Do a git pull
Create a new git branch
Tar and archive existing build
Increment existing files version
Install fedora-kickstarts package.
Import new Fedora kickstarts
	Get from https://git.fedorahosted.org/git/spin-kickstarts.git
	Copy desired kickstarts to working dir.
	From /usr/share/spinkickstarts/
	Workstation
If no existing Tananda build files create them.
Rebranding 
	In %post section - "sed -i -e ‘s/Generic release/LFY Fedora Remix/g’ /etc/fedora-release /etc/issue"

Meld Tananda and Fedora kickstarts
ksflatten to create new Tananda Master kickstart.
Commit to git
Install livecd-tools package.
Create iso
Test iso
Burn iso

Files
=====
 
Final build files.
-------------------
tananda-final-build.ks

Copy Files From KS to Install
-----------------------------
From http://forums.fedoraforum.org/showthread.php?t=280146 -

#. $INSTALL_ROOT is the ks directory.

#. In the %post --nochroot section
##copy somefile to livecd default users home dir
cp somefile $INSTALL_ROOT/destination/

Apps
====

fedy
----
Install with
bash -c 'su -c "curl http://folkswithhats.org/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer"'

* fedy
* fedy-core
* fedy-plugins
* fedy-font-config
* fedy-multimedia-codecs

TODO: Create a way to implement plugins with cli?

Powertop
--------
Laptop power management.

* sudo dnf install -y powertop
* sudo systemctl start powertop.service
* sudo systemctl enable powertop.service

TLP?
----
Laptop power management.

* sudo dnf install tlp
* sudo dnf install tlp-rdw
* systemctl mask systemd-rfkill@.service

Note for F23: you may safely ignore the message "Failed to execute operation: Unit name systemd-rfkill@.service is not valid". The service is masked nonetheless.

Thinkpad Only
+++++++++++++
* sudo dnf install -y --nogpgcheck http://repo.linrunner.de/fedora/tlp/repos/releases/tlp-release-1.0-0.noarch.rpm
* sudo dnf install -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
* sudo dnf install -y --nogpgcheck akmod-tp_smapi akmod-acpi_call kernel-devel


Gnome Extensions
================

Desktop Background
==================
Per https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Desktop_Migration_and_Administration_Guide/customize-desktop-backgrounds.html -

#. Copy image into place.
#. Create a local database for machine-wide settings in /etc/dconf/db/local.d/00-background

	# Specify the dconf path
	[org/gnome/desktop/background]

	# Specify the path to the desktop background image file
	picture-uri='file:///usr/local/share/backgrounds/wallpaper.jpg'
	# Specify one of the rendering options for the background image:
	# 'none', 'wallpaper', 'centered', 'scaled', 'stretched', 'zoom', 'spanned'
	picture-options='scaled'
	# Specify the left or top color when drawing gradients or the solid color
	primary-color='000000'
	# Specify the right or bottom color when drawing gradients
	secondary-color='FFFFFF'

#. Update the system databases:

	dconf update

Set Screen Shield
=================
Per https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Desktop_Migration_and_Administration_Guide/customize-desktop-backgrounds.html -

#. Create a gdm database for machine-wide settings in /etc/dconf/db/gdm.d/01-corp-login:
	[org/gnome/desktop/background]
	picture-uri='file:///opt/corp/background.jpg'

#. Update the system databases:
	dconf update



Fonts
=====

Installing
----------
From https://ask.fedoraproject.org/en/question/7032/how-do-i-install-fonts-in-fedora/ -

#. copy font to /usr/share/fonts
#. sudo fc-cache -v

Subpixel Rendering
------------------
From http://peter.kingofcoders.com/?p=177 -

#) Install rpm fusion repos.
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm'
or
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/
nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

#. Install the freetype-freeworld package.
su -c "dnf install -y freetype-freeworld"

#. Adjust the hinting style and enable RGB anti-aliasing.
gsettings "set" "org.gnome.settings-daemon.plugins.xsettings" "hinting" "slight"
gsettings "set" "org.gnome.settings-daemon.plugins.xsettings" "antialiasing" "rgba"

#. Activate the lcddefault lcdfilter.
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources

#. Reboot.

References
========== 
Remix home page - https://fedoraproject.org/wiki/Remix
Good how to - http://opensourceforu.efytimes.com/2010/01/roll-out-a-fedora-remix/
Sugar Labs (specific to F23) - http://wiki.sugarlabs.org/go/Fedora_23
Excellent Sugar Labs step by step - https://wiki.sugarlabs.org/go/Build_Your_Own_Remix_with_Fedora

