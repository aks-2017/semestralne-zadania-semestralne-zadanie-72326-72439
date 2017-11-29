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

# execute using 'awk -v a="clientID" -v b="clip Folder Input" -v c="number of Segments" -v clip="clip name" -f MP4Client_column_output.awk mpdFile > columnisedOutputFile.txt'

# example
# awk -v a="1" -v b="output" -v c="75" -v clip="clip name" -f MP4Client_column_output.awk mpdFile > outputFile.txt


BEGIN {

	# FS means field seperator, and denotes that charcter that seperates the columns. This script will separate based on a space.
	FS = " "

	# Initialization.

	# number of segments to use in the start up phase - 1 by default - 
	numSegmentStartUpPhase=3;

	# define a few variables
	clientID 		= a; # passed in value
	folderStruct 	= b; # passed in value
	myNumSegments	= c; # passed in value - no header
	clipName		= clip; # passed in value
	
	# create an array
	for(k = 0 ; k < myNumSegments; k++) {
		bufferTime[k] = 0;
	}
	
	# variables
	firstBufferTime = 0;
	firstSegmentReceived = 0;
	baseBufferLevel = 3;
	firstDeliveryRate = 0;
	
	# get the individual rates from the input bitrate list
	split(bitRateList, rateArray, " ");

	# save these values to local array
	y=0;
	for (i in rateArray) {
		repValues[i]=rateArray[i]/1000;
	}
	
	# counters
	counter = 0;
	
	# variables
	timeString = "Date: ";
	httpString = "[HTTP]";
	ftpString  = "fps_";
	mpdString  = "[MPD_IN]";
	isoString  = "[IsoMedia]";
	dashString = "[DASH]";

}

{

	
	# DONE - THIS CODE GETS the segment byte cost and relavent delivery rate
	if($1 == dashString){
		if(($2 == "Downloaded" || $2 == "Download") && $3 != "rate" ){
			
			print $0;
			
		}
	}
}	


END {

	
}
