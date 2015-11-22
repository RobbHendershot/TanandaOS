#!/usr/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    mkmasks.sh 
#%
#% DESCRIPTION
#%    Creates the "mask" files used to modify the default 
#%    kickstart files from Fedora in order to create the 
#%    TananadaOS remix.
#%    
#================================================================
# END HEADER
#================================================================
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
# source the variables file
. $SCRIPTPATH/vars
clear

printf "=============================\n"
printf "=    CREATING MASK FILES    =\n"
printf "=============================\n"
printf "\n"

for i in ${KS_RAW_FILE_LIST[@]}
do
	# copy from original ks to mask ks
	tmp=$i
	tmp=${tmp/#fedora/tananda}
	tmp=${tmp/%.ks/-mask.ks}
	printf "cp %s %s\n" "$i" "$tmp"
	cp "$MASTER_KS_DIR/$i" "$TANANDA_KS_DIR/$tmp"

	# include original file at beginning of each mask file
	printf "adding %s to %s\n" "\"%include $MASTER_KS_DIR/$i\"" "$tmp"
	content=$(cat $TANANDA_KS_DIR/$tmp)
	echo -en "%include $MASTER_KS_DIR/$i\n\n$content" >$TANANDA_KS_DIR/$tmp

	# set permissions
	printf "chown rdhender:rdhender %s\n" "$tmp"
	chown rdhender:rdhender $TANANDA_KS_DIR/$tmp
	printf "chmod 664 %s\n" "$tmp"
	chmod 664 $TANANDA_KS_DIR/$tmp

	printf "\n"

done

printf "==================================\n"
printf "=    DONE CREATING MASK FILES    =\n"
printf "==================================\n"
printf "\n"

