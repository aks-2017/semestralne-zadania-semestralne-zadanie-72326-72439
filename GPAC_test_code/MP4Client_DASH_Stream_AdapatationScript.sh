#!/bin/bash

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation;
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#
# Modifications by Jason Quinlan j.quinlan@cs.ucc.ie 19th February 2016

# This is a bash script for creating the GPAC trace log

# folder variables
script_file_location="Script_Files"
awk_script_location="${script_file_location}/awk_scripts"

# file output format
file_format="Client_Ouput_test"

# ************* INPUT VALUES ***************
# $outputFolderName -
outputFolderName=$1
# $outputFile -
outputFile=$2
# $streamSegNum - number of Segments
streamSegNum=$3
# ${folderDASH[$urlCounter]} - string for folder name
clipName=$4
# $((clientCounter)) -
clientCounter=$5
# ${scenFolder} - output folder location
scenFolder=$6


# ************* ITEMS TO CHANGE ***************
# clip name
folders=($clipName)

# counter
fileCounter=0

for folderName in "${folders[@]}"
do

    # echo $folderName
    # echo $clientCounter
    # echo $outputFolder
    # echo $streamSegNum
    # echo $folderName

    # ****** BEGIN HERE ******

    # extract the adaptation, a number of clients, from the Chrome console log
    awk -v a="${clientCounter}" -v b=${outputFolder} -v c="$streamSegNum" -v clip=${folderName} -f ${awk_script_location}/MP4Client_client_output.awk ./$scenFolder/$outputFolderName/$outputFile > ./$scenFolder/$outputFolderName/${file_format}${clientCounter}.txt

    echo "finished"

done
