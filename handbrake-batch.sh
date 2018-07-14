#!/bin/bash
# Copyright ©2018 Paco Hope
# See attached LICENSE.md file
# 
# Config Variables
SRCDIR="/Volumes/Movies/Library/Home Movies"
DESTBASE="/Volumes/Shared/Movies/converted"
HANDBRAKE_CLI="/Users/paco/bin/HandBrakeCLI"
# The name of the preset, as you see it in the HandBrake window
PRESET="Fast 720p30"
FILEEXT="mp4"

### --- You shouldn't need to configure stuff below here. --- ###

export IFS="
"

# cd to the starting point
cd "${SRCDIR}"

# I'm searching for anything named .AVI, .avi, .MOV, or .mov
for FILE in $(find * -type f \( -iname '*avi' -o -iname '*mov' \))
do
    filename="$(basename "${FILE}")"
    dirname="$(dirname "${FILE}")"
    DESTDIR="${DESTBASE}/${dirname}"

    # If we need to make the destination directory,k do it.
    if [ ! -d "${DESTDIR}" ]
    then
      echo "making \"${DESTDIR}\""
      mkdir -p "${DESTDIR}"
    fi

    extension="${filename##*.}"
    filename="${filename%.*}"
    DESTFILE="${DESTDIR}/${filename}.${FILEEXT}"

    # If the file doesn't already exist, let's run a conversion
    if [ ! -r "${DESTFILE}" ]
    then
      $HANDBRAKE_CLI --verbose=0 \
        -2 -i "${FILE}" \
        -o "${DESTFILE}" \
        --preset="${PRESET}"
        # If the command was successful, set the file modification and creation
        # times to be the same as the source file.
        if [ -r "${DESTFILE}" ]
        then
          touch -a -m -r "${FILE}" "${DESTFILE}"
        fi
    else
      # Already exists. Just warn and move on.
      echo "\"${DESTFILE}\" exists. Skipping."
    fi
done
