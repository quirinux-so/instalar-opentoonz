#!/bin/bash

# File:		install-opentoonz.sh
# Author:	Charlie Martínez® <cmartinez@quirinux.org>
# License:	https://www.gnu.org/licenses/gpl-3.0.txt
# Description:	Download the source code for the newest version of OpenToonz, compile it, and install it.
# Version:	1.1

clear

echo "--------------------------------------------------------------
QUIRINUX PRO: COMPILE AND INSTALL OPENTOONZ
--------------------------------------------------------------
  ___                 _____                     
 / _ \ _ __   ___ _ _|_   _|__   ___  _ __  ____
| | | | '_ \ / _ \ '_ \| |/ _ \ / _ \| '_ \|_  /
| |_| | |_) |  __/ | | | | (_) | (_) | | | |/ / 
 \___/| .__/ \___|_| |_|_|\___/ \___/|_| |_/___|
      |_|
Download source code and install by compiling from code
the newest version of the professional animation program
OpenToonz with which you can replace Toon Boom Harmony.
Compatible with Debian Buster, Devuan Beowulf and Ubuntu 20.4
1 Download, compile and install OpenToonz 1.5
0 Leave
"

read -p " Your answer-> " opc 

case $opc in

"1") 

# Compile OpenToonz 1.5 from source code

sudo apt-get update -y
for paquetes_opentoonz in wget build-essential git cmake pkg-config libboost-all-dev qt5-default qtbase5-dev libqt5svg5-dev qtscript5-dev qttools5-dev qttools5-dev-tools libqt5opengl5-dev qtmultimedia5-dev libqt5multimedia5-plugins libqt5serialport5-dev libsuperlu-dev liblz4-dev libusb-1.0-0-dev liblzo2-dev libpng-dev libjpeg-dev libglew-dev freeglut3-dev libfreetype6-dev libjson-c-dev qtwayland5 libmypaint-dev libopencv-dev libturbojpeg-dev; do sudo apt-get install -y $paquetes_opentoonz; done

mkdir -p /opt/tmp/opentoonz
sudo wget  --no-check-certificate 'https://github.com/opentoonz/opentoonz/archive/refs/tags/v1.5.0.tar.gz' -O /opt/tmp/opentoonz/opentoonz-1.5.0.tar.gz
tar -xzvf /opt/tmp/opentoonz/opentoonz-1.5.0.tar.gz -C /opt/tmp/
cd /opt/tmp/opentoonz-1.5.0

mkdir -p $HOME/.config/OpenToonz
cp -r /opt/tmp/opentoonz-1.5.0/stuff $HOME/.config/OpenToonz/

cd /opt/tmp/opentoonz-1.5.0/thirdparty/tiff-4.0.3
./configure --with-pic --disable-jbig
make -j$(nproc)
cd ../../

cd toonz
mkdir build
cd build
cmake ../sources
make -j$(nproc)

# Download and copy the start menu icon

sudo mv /opt/opentoonz/bin/opentoonz /opt/opentoonz/bin/opentoonz2
sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/FZz85jagrQLCjjB/download' -O /opt/tmp/opentoonz/opentoonz-icon.tar
sudo mv /opt/tmp/opentoonz /opt/tmp/opentoonz-tmp
sudo tar -xvf /opt/tmp/opentoonz-tmp/opentoonz-icon.tar -C /
mv /opt/tmp/opentoonz /opt/opentoonz/opentoonz
cp -r /opentoonz-icon/* /
rm -r /opentoonz-icon/

# Creating start command

sudo chmod -R 775 /opt/opentoonz
sudo chown -R $USER /opt/opentoonz

FILE="/usr/local/bin/opentoonz"

FILE="/usr/local/bin/opentoonz"

if [ -f "$FILE" ]; then

sudo rm /usr/local/bin/opentoonz
mv /opt/tmp/opentoonz-tmp/* /opt/opentoonz/bin/
touch /opt/opentoonz/opentoonz
echo "/opt/opentoonz/bin/./opentoonz2" > /opt/opentoonz/opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/opentoonz
sudo chmod 777 /usr/local/bin/opentoonz

else

mv /opt/tmp/opentoonz-tmp/* /opt/opentoonz/bin/
touch /opt/opentoonz/opentoonz
echo "/opt/opentoonz/bin/./opentoonz2" > /opt/opentoonz/opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/opentoonz
sudo chmod 777 /usr/local/bin/opentoonz

fi

# Delete temp files

sudo rm -rf /opt/tmp/*
sudo rm /opt/opentoonz/opentoonz-icon.tar
sudo rm /opt/opentoonz/bin/opentoonz-1.5.0.tar.gz

clear

echo "--------------------------------------------------------------
INSTALLATION FINISHED SUCCESSFUL
--------------------------------------------------------------
 
Congratulations! OpenToonz is already on your system and you can
open it by going to ${bold}Applications> Graphics> OpenToonz ${normal}or fro
the terminal with the command ${bold}opentoonz. ${normal}
"

exit 0

;;

"0")

clear

exit 0

;; 

esac

