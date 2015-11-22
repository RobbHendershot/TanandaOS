#!/usr/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    mkbuildfiles.sh 
#%
#% DESCRIPTION
#%    Uses ksflatten to create the intermediate and final
#%    kickstart files needed to create the TananadaOS remix.
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

printf "==============================\n"
printf "=    CREATING BUILD FILES    =\n"
printf "==============================\n"
printf "\n"

for i in ${KS_MASK_FILE_LIST[@]}
do
	build_file=${i/mask/build}
	printf "ksflatten -c %s -o %s\n" $i $build_file
	ksflatten -c $i -o $build_file
	printf "\n"

done


printf "\n"
printf "===================================\n"
printf "=    DONE CREATING BUILD FILES    =\n"
printf "===================================\n"
printf "\n"