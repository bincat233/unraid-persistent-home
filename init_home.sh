#!/bin/bash
# Note: You can't create symlinks on FAT32 filesystems.
# 		  So, you can't link whole folders, only files.

SRC_DIR="/boot/config/home_root"
DEST_DIR="/root"

function link() {
	# Link if the link not exist
	if [ ! -L "$DEST_DIR/persistent" ]; then
		ln -s $SRC_DIR $DEST_DIR/stable
	fi
	
	# Recursively link all files in SRC_DIR to DEST_DIR
	# If a path in DEST_DIR is not exist, create it
	find $SRC_DIR -type f | while read file
	do
		# Get the relative path of the file
		rel_path=${file#$SRC_DIR}
		# Get the destination path
		dest_path=$DEST_DIR$rel_path
		# Get the destination directory
		dest_dir=$(dirname $dest_path)
		# Create the destination directory if not exist
		if [ ! -d $dest_dir ]; then
			mkdir -p $dest_dir
		fi
		# If the file is exist and has the force variable equals 1, remove it.
		# Or warning with red color
		if [ -f $dest_path ]; then
			if [ $force -eq 1 ]; then
				rm $dest_path
			else
				echo -e "\e[31mWarning: $dest_path is exist, remove it or use -f to force\e[0m"
			fi
		fi
		# Link the file
		ln -s $file $dest_path
	done
}

function push() {
	# Recursively push all files in DEST_DIR to SRC_DIR
	# If a path in SRC_DIR is not exist, create it
	find $DEST_DIR -type f | while read file
	do
		# Get the relative path of the file
		rel_path=${file#$DEST_DIR}
		# Get the source path
		src_path=$SRC_DIR$rel_path
		# Get the source directory
		src_dir=$(dirname $src_path)
		# Create the source directory if not exist
		if [ ! -d $src_dir ]; then
			mkdir -p $src_dir
		fi
		if [ -f $src_path ]; then
			# Warning in red color if the file if it is exist
			# Or remove it if the force variable equals 1
			if [ $force -eq 1 ]; then
				rm $src_path
			else
				echo -e "\e[31mWarning: $src_path is exist, remove it or use -f to force\e[0m"
			fi
		else
			# Copy the file
			cp $file $src_path
		fi
	done
}

function help() {
	echo "Usage: $0 [OPTION]"
	echo "  -l, --link		Link the files in $SRC_DIR to $DEST_DIR"
	echo "  -p, --push		Push the files in $DEST_DIR to $SRC_DIR"
	echo "  -f, --force		Force to remove the file if it is exist"
	echo "  -h, --help		Show this help"
}
# Parse the command line arguments (with shift)
if [ $# -eq 0 ]; then
	help
	exit 1
fi
while [ $# -gt 0 ]; do
	case "$1" in
		-l|--link)
			link
			;;
		-p|--push)
			push
			;;
		-f|--force)
			force=1
			;;
		-h|--help)
			help
			;;
		*)
			echo "Unknown option: $1"
			help
			exit 1
			;;
	esac
	shift
done