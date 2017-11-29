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

This folder contains:

1.	DASH_MP4Client_script.sh
This script calls GPAC and creates the log traces

example usage:
DASH_MP4Client_script.sh <ExpFolder> <clientId> <urlNumber> <streamSegNum> <videoDriver>
ExpFolder -> export folder to store output folder and files
clientId -> number from 1 upwards
urlNumber -> number from 0 upwards
streamSegNum -> # of segments to download
videoDriver -> 'X11' denotes viewable player and 'RAW' denotes no player displayed


2.	MP4Client_DASH_Stream_AdapatationScript.sh
This script is used to call the awk script with the correct parameters.


3.	Script_Files/awk_scripts/MP4Client_client_output.awk
This script prints the deliver time of each DASH segment from the GPAC log traces


4.	source_and_build_GPAC_ubuntu.sh
This script will install GPAC on a fresh install of Ubuntu 14.04, c/w all requried dependencies for H.264 and H.265 decoding.


Note:
You may need to make the bash scripts executable depending on your system.  chmod +x <fileName.sh>