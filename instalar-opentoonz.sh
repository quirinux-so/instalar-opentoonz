# !/bin/bash
# instalar-opentoonz.sh

# Script para compilar e instalar la versión más reciente de OpenToonz
# Compatible con Debian Buster, Devuan Beowulf y Ubuntu 10.04. 

# Licencia GPLv3, Autor de este instalador: Charlie Martínez®

clear

echo "
  ___                 _____                     
 / _ \ _ __   ___ _ _|_   _|__   ___  _ __  ____
| | | | '_ \ / _ \ '_ \| |/ _ \ / _ \| '_ \|_  /
| |_| | |_) |  __/ | | | | (_) | (_) | | | |/ / 
 \___/| .__/ \___|_| |_|_|\___/ \___/|_| |_/___|
      |_|
--------------------------------------------------------------
QUIRINUX PRO: COMPILAR E INSTALAR OPENTOONZ
--------------------------------------------------------------

Descargar código fuente e instalar compilando desde el código
la versión más nueva del programa de animación profesional 
OpenToonz con el que puedes reemplazar a Toon Boom Harmony.


1 Descargar, compilar e instalar OpenToonz
0 Salir



"

read -p "Tu respuesta-> " opc 

case $opc in

"1") 

# COMPILANDO OPENTOONZ DESDE SU CÓDIGO FUENTE

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

# DESCARGANDO Y COPIANDO EL ÍCONO DEL MENÚ DE INICIO

sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/FZz85jagrQLCjjB/download' -O /opt/opentoonz/opentoonz-icon.tar
sudo tar -xf /opt/opentoonz/opentoonz-icon.tar -C /

;;

"0")

exit 0

;; 

esac 
