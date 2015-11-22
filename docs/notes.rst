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
	Copy desired kickstarts to working dir.
	From /usr/share/spinkickstarts/
	Workstation
If no existing Tananda build files create them.
Merge Tananda and Fedora kickstarts
Rebranding 
	On %post section - "sed -i -e ‘s/Generic release/LFY Fedora Remix/g’ /etc/fedora-release /etc/issue"
ksflatten to create new Tananda Master kickstart.
Commit to git
Install livecd-tools package.
Create iso
Test iso
Burn iso

Files
=====
# Mask files.
tananda-live-base-mask.ks  
tananda-live-workstation-mask.ks  
tananda-repo-mask.ks  
tananda-worstation-packages-mask.ks

# Intermediate files.
tananda-live-base-build.ks  
tananda-live-workstation-build.ks  
tananda-repo-build.ks  
tananda-worstation-packages-build.ks

# Final build files.
tananda-final-build.ks 

References
========== 
Remix home page - https://fedoraproject.org/wiki/Remix
Good how to - http://opensourceforu.efytimes.com/2010/01/roll-out-a-fedora-remix/
Sugar Labs (specific to F23) - http://wiki.sugarlabs.org/go/Fedora_23
Excellent Sugar Labs step by step - https://wiki.sugarlabs.org/go/Build_Your_Own_Remix_with_Fedora

