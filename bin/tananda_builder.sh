#!/bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
# source the variables file
source $SCRIPTPATH/vars

###############################################################################
#  USEFUL FUNCTIONS
###############################################################################
iso_list=()

function draw_line () {
	printf "%60s\n" | tr ' ' $1
}

function header () {
	clear
	draw_line "="
	printf "%s\n" "# $1"
	draw_line "="
	printf "\n"
}

function section_heading () {
	draw_line "-"
	printf "%s\n" "$1"
	draw_line "-"
	printf "\n"
}

function update_iso_list {
	section_heading "ISO File List"
	iso_list=$(find $TANANDA_BASE_DIR/ -name "*.iso")
}

function clean_tmp {
	section_heading "Cleaning Temp Dir"
	sudo rm -Rf /home/tananda/*
	printf "Temp dir clean complete.\n"
}

function make_iso {
	# header
	header "Create ISO Image"

	# zenity --progress \
	#   --title="Creating A New ISO Image" \
	#   --percentage=0
	section_heading "Flattening files."
	cd $TANANDA_KS_DIR
	ksflatten -c tananda23-live-workstation.ks -o tananda23-final.ks

	section_heading "Creating ISO."
	cd $TANANDA_BASE_DIR
	sudo livecd-creator \
	--config=$TANANDA_KS_DIR/tananda$NEW_VERSION-final.ks \
	--fslabel=$DIST_NAME \
	--releasever=$NEW_VERSION \
	--title=$DIST_NAME \
	--product=$DIST_NAME \
	--cache=/home/tananda/cache/ \
	--tmpdir=/home/tananda/tmp/ \
	--verbose \
	--debug |tee $TANANDA_DOC_DIR/livecd-creator.log

	sudo chown rdhender:rdhender $TANANDA_BASE_DIR/*.iso
	sudo chmod 775 -R $TANANDA_BASE_DIR/*.iso

}

function test_iso {
	# header
	header "Testing ISO Image"

	PS3="Select an ISO to test: "
	#filename=$(find $TANANDA_BASE_DIR/ -name "*.iso"|zenity --list --title="Choose ISO To Test" --column "ISO Files" --height 200 --width 800)
	options=$(find $TANANDA_BASE_DIR/ -name "*.iso")
	select opt in ${options[@]}; do
		case "$REPLY" in
			$REPLY) qemu-kvm -m 1G -vga std -cdrom $opt; break;;
		esac
	done

	printf "\n"
}

function write_iso {
	# header
	header "Write ISO Image"

	sudo livecd-iso-to-disk --format --efi --force $DIST_NAME.iso $1
}

###############################################################################
#  MAIN BLOCK
###############################################################################
function main {
	export COLUMNS=20

	# header
	header "Running Tananda Builder"

	local main_options=("Create new version." "Build new ISO file." "Test an ISO image." "Write ISO image." "Clean Temp Dirs." "ISO List.")
	PS3="Pick an option: "

	select opt in "${main_options[@]}" "Quit."; do
		case "$REPLY" in
			1) printf "%s\n" "opt: $opt menu: $REPLY";;
			2) make_iso;;
			3) test_iso;;
			4) write_iso;;
			5) clean_tmp;;
			6) update_iso_list; printf "%s\n" $iso_list;;

			$(( ${#main_options[@]}+1 )) ) printf "%s\n\n" "Quitting!"; break;;
			*) printf "%s\n" "Invalid option. Try another one."; continue;
		esac
	done
}

main
