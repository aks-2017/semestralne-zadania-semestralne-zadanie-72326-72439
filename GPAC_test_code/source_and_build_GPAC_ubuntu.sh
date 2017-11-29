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

# Script to install GPAC on Ubuntu 14.04, c/w all requried dependencies for H.264 and H.265 decoding.

# add sudo as needed or run the entire script as sudo "sudo source_and_build_GPAC_ubuntu.sh"

# update apt-get for ubuntu 14.04
echo ""
echo "update apt-get on 14.04"
echo ""
apt-get update

# get apt-get dependencies
echo ""
echo "get build dependencies"
echo ""
apt-get -y --force-yes install autoconf automake build-essential gedit git yasm libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev libx264-dev cmake mercurial libmp3lame-dev nasm libopus-dev subversion make g++ libjpeg62-dev libpng12-dev libopenjpeg-dev libmad0-dev libfaad-dev libogg-dev liba52-0.7.4-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavresample-dev libxv-dev x11proto-video-dev libgl1-mesa-dev x11proto-gl-dev linux-sound-base libxvidcore-dev libssl-dev libjack0 libjack-dev libasound2-dev libpulse-dev dvb-apps libavcodec-extra libavdevice-dev libmozjs185-dev libjack0 libjack-dev

# define some folder structures
echo ""
echo "Make folder structure"
echo ""
mkdir ~/ffmpeg_sources
mkdir ~/Code

# next download the different packages
# 
# x264
echo ""
echo "x264 build"
echo ""
cd ~/ffmpeg_sources
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
PATH="$HOME/bin:$PATH" make
make install
make distclean

# x265
echo ""
echo "x265 build"
echo ""
cd ~/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd ~/ffmpeg_sources/x265/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install
make distclean
cp ~/ffmpeg_build/bin/x265 ~/bin

# libfdk-aac - not really needed for our needs, as it is audio
echo ""
echo "libfdk-aac build"
echo ""
cd ~/ffmpeg_sources
wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master
tar xzvf fdk-aac.tar.gz
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean

# libvpx - not really needed for our needs, as it is audio
echo ""
echo "libvpx build"
echo ""
cd ~/ffmpeg_sources
wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2
tar xjvf libvpx-1.5.0.tar.bz2
cd libvpx-1.5.0
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests
PATH="$HOME/bin:$PATH" make
make install
make clean

# ffmpeg
cd ~/ffmpeg_sources
echo ""
echo "ffmpeg build"
echo ""
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree
PATH="$HOME/bin:$PATH" make
make install
make distclean
hash -r

# openHEVC
echo ""
echo "openHEVC build"
echo ""
cd ~/Code
git clone https://github.com/OpenHEVC/openHEVC.git
cd openHEVC
git checkout hevc_rext
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE ..
make
make install

# GPAC - newest release
echo ""
echo "GPAC build"
echo ""
cd ~/Code
git clone https://github.com/gpac/gpac.git
cd gpac
./configure
make
make install

echo ""
echo "update terminal to reference the new executables in ~/bin"
echo ""
source ~/.profile

# test GPAC for x264 and x265
# MP4Client <url_to_mpd_file>

