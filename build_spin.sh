#!/bin/sh

Create_ISO() {
cat <<- _EOF_
	sudo livecd-creator\
	--config=./my_kickstarts/tananda-live-cinnamon.ks 
	--fslabel=$BUILD_NAME \
	--releasever=23 \
	--title=$BUILD_NAME \
	--product=$BUILD_NAME \
	--cache=/home/tananda/cache/ \
	--tmpdir=/home/tananda/tmp/ \
	--verbos \
	--efi
_EOF_
}

Print_Header() {
	# Program header
	WIDTH=`tput cols`
	(( HALF_WIDTH=$WIDTH/2 ))
	HEADER="=== Tananda OS Build ==="
	DIVIDER="========================"
	declare -i HEADER_LEN=${#HEADER}
	(( HEADER_START= $HALF_WIDTH - $HEADER_LEN/2 ))

	clear
	printf "\n%-${HEADER_START}s%-${HEADER_LEN}s\n" "" "$DIVIDER"
	printf "%-${HEADER_START}s%-${HEADER_LEN}s" "" "$HEADER"
	printf "\n%-${HEADER_START}s%-${HEADER_LEN}s\n\n" "" "$DIVIDER"
}

Print_Header

# Set, collect or create variables
DEFAULT_VERSION="23"
DEFAULT_SPIN_NAME="Tananda"
DEFAULT_WORKING_DIR="/home/tananda"
DEFAULT_KS_DIR="./my_kickstarts"
DEFAULT_KS_FILE="tananda-live-cinnamon.ks"
FORMAT1=" %-35s: "
FORMAT2=" %-60s\n"

printf $FORMAT1 "Spin Name ($DEFAULT_SPIN_NAME)"
read SPIN_NAME
if [ "$SPIN_NAME" = "" ]; then SPIN_NAME=$DEFAULT_SPIN_NAME; fi 

printf $FORMAT1 "Build Version ($DEFAULT_VERSION)"
read VERSION
if [ "$VERSION" = "" ]; then VERSION=$DEFAULT_VERSION; fi
BUILD_NAME="$SPIN_NAME-$VERSION"

printf $FORMAT1 "KS Dir ($DEFAULT_KS_DIR)"
read KS_DIR
if [ "$KS_DIR" = "" ]; then KS_DIR=$DEFAULT_KS_DIR; fi

printf $FORMAT1 "KS File ($DEFAULT_KS_FILE)"
read KS_FILE
if [ "$KS_FILE" = "" ]; then KS_FILE=$DEFAULT_KS_FILE; fi
KS_PATH="$KS_DIR/$KS_FILE"

Print_Header

printf $FORMAT2 "-----------------------------------------------------------"
printf $FORMAT2 "Build name is $BUILD_NAME"
printf $FORMAT2 "KS is $KS_PATH"
printf $FORMAT2 "-----------------------------------------------------------"

