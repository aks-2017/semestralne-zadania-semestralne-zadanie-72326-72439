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

# This script is called using:
# DASH_MP4Client_script.sh <ExpFolder> <clientId> <urlNumber> <streamSegNum> <videoDriver>
# ExpFolder -> export folder to store output folder and files
# clientId -> number from 1 upwards
# urlNumber -> number from 0 upwards
# streamSegNum -> # of segments to download
# videoDriver -> 'X11' denotes viewable player and 'RAW' denotes no player displayed

# determine what has been passed in
if [ $# -eq 0 ]
  then
    # ExpFolder folder
    scenFolder="."
    # number of clients
    clientCounter=1
    # clip to use
    urlCounter=0
    # number of segments to stream - based on 4 second segment for 16 minutes
    streamSegNum=240;
    # video output to use
    videoDriver="RAW"
fi

if [ $# -eq 1 ]
  then
    # scenario folder
    scenFolder=$1
    # number of clients
    clientCounter=1
    # clip to use
    urlCounter=0
    # number of segments to stream
    streamSegNum=240;
    # video output to use
    videoDriver="RAW"
fi

if [ $# -eq 2 ]
then
    # scenario folder
    scenFolder=$1
    # number of clients
    clientCounter=$2
    # clip to use
    urlCounter=0
    # number of segments to stream
    streamSegNum=240;
    # video output to use
    videoDriver="RAW"
fi

if [ $# -eq 3 ]
then
    # scenario folder
    scenFolder=$1
    # number of clients
    clientCounter=$2
    # clip to use
    urlCounter=$3
    # number of segments to stream
    streamSegNum=240;
    # video output to use
    videoDriver="RAW"
fi

if [ $# -eq 4 ]
then
    # scenario folder
    scenFolder=$1
    # number of clients
    clientCounter=$2
    # clip to use
    urlCounter=$3
    # number of segments to stream
    streamSegNum=$4
    # video output to use
    videoDriver="RAW"
fi

if [ $# -eq 5 ]
then
    # scenario folder
    scenFolder=$1
    # number of clients
    clientCounter=$2
    # clip to use
    urlCounter=$3
    # number of segments to stream
    streamSegNum=$4
    # video output to use
    videoDriver=$5

fi

# list of urls - each url is an adaptive DASH stream
urlsDASH=(
	http://10.0.0.7/VOD/bbb_enc_10min_x264_dash.mpd
	)

# just a check to make sure the correct url is being requested
if [ $urlCounter -ge ${#urlsDASH[@]} ]
then
    echo "the value of the third arguement, urlCounter =" $urlCounter ", and is greater than the number of clips available to view"
    exit
fi

echo "Setting scenario folder to $scenFolder, client number to $clientCounter, using url $urlCounter, number of segments to download to $streamSegNum, and videoDriver to use to $videoDriver"

# folder structure - string used to create the output file
folderDASH=( bbb_x264 ed_x265 )

# store the start time
dt=`date '+%d_%m_%Y_%H_%M_%S'`

# create a local folder for this test
outputFolder=${scenFolder}/${dt}_clientID$((clientCounter))
outputFolderName=${dt}_clientID$((clientCounter))
mkdir -p $outputFolder

# copy the current default GPAC config file to our local folder
cp ~/.gpac/GPAC.cfg $outputFolder/ourGpacrc

# change the player output from X11 to RAW
awk -v vid=$videoDriver 'BEGIN{videodriver=vid; streamSegnum=numSeg;} {if($0 ~ "DriverName=X11"){ printf("DriverName=%s Video Output\n", videodriver); }else{print($0)}}' $outputFolder/ourGpacrc > $outputFolder/ourGpacrc_temp
mv $outputFolder/ourGpacrc_temp $outputFolder/ourGpacrc

# output trace file
outputFile=${folderDASH[$urlCounter]}_clientID$((clientCounter)).txt
#-cfg $outputFolder/ourGpacrc
echo "MP4Client -exit -lf ~/logs/$outputFile -logs dash:network@debug ${urlsDASH[$urlCounter]}"

# run our GPAC client script
MP4Client -exit -lf ~/logs/$outputFile -logs dash:network@debug ${urlsDASH[$urlCounter]}

# RAW does not seem to stop in GPAC, so stop the player after the correct number of segments
# sleep for the number of segments plus 15, times the segment duration (pass this in if needed)
#sleep $[$[$streamSegNum+15]*4]
#killall -9 MP4Client

# create the columned trace file
#~/GPAC_test_code/MP4Client_DASH_Stream_AdapatationScript.sh $outputFolderName $outputFile $streamSegNum ${folderDASH[$urlCounter]} $((clientCounter)) ${scenFolder}


echo "Done"

