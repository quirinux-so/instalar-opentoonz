#!/bin/bash

# File:	install-opentoonz.sh
# Author:	Charlie Martínez® <cmartinez@quirinux.org>
# License:	https://www.gnu.org/licenses/gpl-3.0.txt
# Description:	Download OpenToonz source code, compile and install it.
# Version:	1.00

clear

echo "
  ___                 _____                     
 / _ \ _ __   ___ _ _|_   _|__   ___  _ __  ____
| | | | '_ \ / _ \ '_ \| |/ _ \ / _ \| '_ \|_  /
| |_| | |_) |  __/ | | | | (_) | (_) | | | |/ / 
 \___/| .__/ \___|_| |_|_|\___/ \___/|_| |_/___|
      |_|
--------------------------------------------------------------
QUIRINUX PRO: COMPILE AND INSTALL OPENTOONZ
--------------------------------------------------------------
Download source code and install by compiling from code
the newest version of the professional animation program
OpenToonz with which you can replace Toon Boom Harmony.

1 Download, compile and install OpenToonz
0 Leave

"

read -p " Your answer-> " opc 

case $opc in

"1") 

# Install installer dependencies.

sudo apt-get update -y
for paquetes_wget in wget git software-properties-common; do sudo apt-get install -y $paquetes_wget; done
sudo apt-get install -f -y
sudo apt-get autoremove --purge -y

# Compile OpenToonz from source code

sudo apt-get update -y
for paquetes_opentoonz in build-essential git cmake pkg-config libboost-all-dev qt5-default qtbase5-dev libqt5svg5-dev qtscript5-dev qttools5-dev qttools5-dev-tools libqt5opengl5-dev qtmultimedia5-dev libsuperlu-dev liblz4-dev libusb-1.0-0-dev liblzo2-dev libpng-dev libjpeg-dev libglew-dev freeglut3-dev libfreetype6-dev libjson-c-dev qtwayland5 libqt5multimedia5-plugins; do sudo apt-get install -y $paquetes_opentoonz; done
for paquetes_opentoonz2 in libmypaint-dev; do sudo apt-get install -y $paquetes_opentoonz2; done
mkdir /opt/tmp
cd /opt/tmp
git clone https://github.com/opentoonz/opentoonz
mkdir -p $HOME/.config/OpenToonz
cp -r opentoonz/stuff $HOME/.config/OpenToonz/
cat << EOF > $HOME/.config/OpenToonz/SystemVar.ini
[General]
OPENTOONZROOT="$HOME/.config/OpenToonz/stuff"
OpenToonzPROFILES="$HOME/.config/OpenToonz/stuff/profiles"
TOONZCACHEROOT="$HOME/.config/OpenToonz/stuff/cache"
TOONZCONFIG="$HOME/.config/OpenToonz/stuff/config"
TOONZFXPRESETS="$HOME/.config/OpenToonz/stuff/fxs"
TOONZLIBRARY="$HOME/.config/OpenToonz/stuff/library"
TOONZPROFILES="$HOME/.config/OpenToonz/stuff/profiles"
TOONZPROJECTS="$HOME/.config/OpenToonz/stuff/projects"
TOONZROOT="$HOME/.config/OpenToonz/stuff"
TOONZSTUDIOPALETTE="$HOME/.config/OpenToonz/stuff/studiopalette"
EOF
cd /opt/tmp/opentoonz/thirdparty/tiff-4.0.3
./configure --with-pic --disable-jbig
make -j$(nproc)
cd ../../
cd /opt/tmp/opentoonz/toonz
mkdir build
cd build
cmake ../sources
make -j$(nproc)
sudo make install 
sudo apt-get install -f -y
sudo apt-get autoremove --purge -y

# Download and copy the start menu icon

sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/FZz85jagrQLCjjB/download' -O /opt/opentoonz/opentoonz-icon.tar
sudo tar -xf /opt/opentoonz/opentoonz-icon.tar -C /

;;

"0")

exit 0

;; 

esac 
