#!/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    ${SCRIPT_NAME} [-hv] [-o[file]] args ...
#%
#% DESCRIPTION
#%    This is a script template
#%    to start any good shell script.
#%
#================================================================
# END_OF_HEADER
#================================================================
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
# source the variables file
source $SCRIPTPATH/vars
clear

# header
header "Create New Tananda Release"

# get and save version numbers
OLD_VERSION=$NEW_VERSION
read -p "New version number: " NEW_VERSION
sed -ri "s/^OLD_VERSION=.+/OLD_VERSION=${OLD_VERSION}/g" $SCRIPTPATH/vars
sed -ri "s/^NEW_VERSION=.+/NEW_VERSION=${NEW_VERSION}/g" $SCRIPTPATH/vars

# Initiate a git pull
section_heading "Refreshing Tananda from repo."
cd $TANANDA_BASE_DIR
git pull origin master

# Check for previous versions
section_heading "Checking for previous versions."
[ "$(ls -A $TANANDA_KS_DIR)" ] && OLD_VERSION_PRESENT="true" || OLD_VERSION_PRESENT=""
if [ $OLD_VERSION_PRESENT ]; then
	printf "Previous version found."
else
	printf "No previous version found."
fi

# Tar and archive existing build
if [ $OLD_VERSION_PRESENT ]; then
	section_heading "Archiving previous versions."
	cd $TANANDA_KS_DIR
	tar -cvzf $TANANDA_ARCHIVE_DIR/Tananda-$OLD_VERSION.tar.gz $TANANDA_KS_DIR/*
	#mv $TANANDA_KS_DIR/*.gz $TANANDA_ARCHIVE_DIR/
fi

# Create a new git branch
section_heading "Creating new branch for version $NEW_VERSION."
cd $TANANDA_BASE_DIR
git checkout -b $NEW_VERSION

# Refresh Fedora master kickstarts.
section_heading "Refreshing master kickstart files."
cd $MASTER_KS_DIR
git pull origin master

# Import master kickstarts
section_heading "Importing master kickstart files."
for i in ${KS_RAW_FILE_LIST[@]}
do
	printf "Importing %s\n" $i
	cp $MASTER_KS_DIR/$i $TANANDA_KS_DIR/
done

# If no existing Tananda build files create them.
section_heading "Create Tananda kickstart files if needed."
if [ $OLD_VERSION_PRESENT ]; then
	printf "Spin kickstart files already exist, skipping create."
else
	printf "Creating spin kickstart files."
	for i in ${KS_RAW_FILE_LIST[@]}
	do
		# copy from original ks to mask ks
		tmp=$i
		tmp=${tmp/#fedora/tananda$NEW_VERSION}
		printf "Creating %s\n" $tmp
		cp "$MASTER_KS_DIR/$i" "$TANANDA_KS_DIR/$tmp"
	done

fi

printf "\n%s\n\n" $header_line
