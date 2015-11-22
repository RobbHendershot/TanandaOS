%include tananda-live-base.ks
%include tananda-workstation-packages.ks

#part / --size 20000

%post

# This is a huge file and things work ok without it
rm -f /usr/share/icons/HighContrast/icon-theme.cache

cat >> /etc/rc.d/init.d/livesys << EOF


# disable updates plugin
cat >> /usr/share/glib-2.0/schemas/org.gnome.software.gschema.override << FOE
[org.gnome.software]
download-updates=false
FOE

# don't run gnome-initial-setup
mkdir ~liveuser/.config
touch ~liveuser/.config/gnome-initial-setup-done

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'rhythmbox.desktop', 'shotwell.desktop', 'org.gnome.Nautilus.desktop', 'anaconda.desktop']
FOE

  # Make the welcome screen show up
  if [ -f /usr/share/anaconda/gnome/fedora-welcome.desktop ]; then
    mkdir -p ~liveuser/.config/autostart
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop /usr/share/applications/
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop ~liveuser/.config/autostart/
  fi
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end

%post

#!/bin/sh

# Sublime Text 3 install with Package Control
# based on http://simonewebdesign.it/blog/install-sublime-text-3-on-fedora-20/

ST3URL='http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2'
PCURL="https://sublime.wbond.net/Package%20Control.sublime-package"

curl -o ~/st3.tar.bz2 $ST3URL
if tar -xf ~/st3.tar.bz2 --directory=$HOME; then
  sudo mv ~/sublime_text_3/ /opt/
  sudo ln -s /opt/sublime_text_3/sublime_text /bin/subl
fi
rm ~/st3.tar.bz2

# Package Control - The Sublime Text Package Manager: https://sublime.wbond.net
curl -o ~/Package\ Control.sublime-package $PCURL
sudo mv ~/Package\ Control.sublime-package /opt/sublime_text_3/Packages/

# Add to applications list
cat << EOF > ~/.local/share/applications/sublime.desktop
[Desktop Entry]
Name=Sublime Text
Exec=subl %F
MimeType=text/plain;
Terminal=false
Type=Application
Icon=/opt/sublime_text_3/Icon/128x128/sublime-text.png
Categories=Utility;TextEditor;Development;
EOF

echo ""
echo "Sublime Text 3 installed successfully!"
echo "Run with: subl"

# Install OH-MY-ZSH
curl -L http://install.ohmyz.sh | sh

%end

%post

cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

%end

