%include /usr/share/spin-kickstarts/fedora-workstation-packages.ks

%packages

# Get rid of the stuff we don't want.
-@firefox
-@libreoffice
-@workstation-product


# Add the stuff that got left off.
audacity
fritzing
git
inkscape
inkscape-docs
meld
openscad
pencil
qemu?
redshift
redshift-gtk
transmission
transmission-gtk
unetbootin
zsh

# rebranding
-fedora-productimg-workstation
-fedora-logos
-fedora-release
-fedora-release-notes
generic-release
generic-logos
generic-release-notes

%end
