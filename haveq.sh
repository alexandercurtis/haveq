#!/bin/bash

# Checks whether files already exist on my NAS

# Alex Curtis 29/9/2016

# First argument is file/directory to search
# If a directory, check each file in directory and subdirs
# If a file, check the file


function showRm(){
  if [ ${rev} = true ]; then
    echo "rm '$1' # $3 at $2"
  else
    echo "rm '$2' # $3 at $1"
  fi
}

findByMD5(){
    local f="$1"
    sum=($(md5sum "$f"))
    while IFS= read -r j; do
      if [ "$f" != "$j" -a -s "$f" ]; then
        showRm "$j" "$f" "Have already"
      elif [ ! -s "$j" ]; then
        showRm "$j" "$f" "Zero bytes"
      fi
    done < <(grep ${sum} /mnt/diskstation/shared/index.txt | cut -c 35-)
}

check(){
    if [ -f "$1" ]; then
      findByMD5 "$1"
    elif [ -d "$1" ]; then
      for f in "$1"/*; do
        check "$f"
      done
    fi
}

if [ "$1" == "-t" ]; then
  d="$2"
  rev=true
else
  d="$1"
  rev=false
fi

check "$d"




