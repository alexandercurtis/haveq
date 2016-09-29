#!/bin/bash

# Checks whether files already exist on my NAS

# Alex Curtis 29/9/2016

# First argument is file/directory to search
# If a directory, check each file in directory and subdirs
# If a file, check the file

findByMD5(){
    sum=($(md5sum $1))
    while IFS= read -r j; do
      echo "rm '$j' # Have at $1"
    done < <(grep ${sum} /mnt/diskstation/shared/index.txt | cut -c 35-)
}


check(){
    if [ -f $1 ]; then
      findByMD5 $1
    elif [ -d $1 ]; then
      for f in $1/*; do
        check ${f}
      done
    fi
}

check $1




