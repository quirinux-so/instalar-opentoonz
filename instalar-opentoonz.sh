#!/bin/bash

# Nombre:	instalar-opentoonz.sh
# Autor:	Charlie Martínez® <cmartinez@quirinux.org>
# Licencia:	https://www.gnu.org/licenses/gpl-3.0.txt
# Descripción:	Descarga el código fuente de la versión más nueva de OpenToonz, lo compila y lo instala. 
# Versión:	1.1

bold=$(tput bold)
normal=$(tput sgr0)
${bold}
${normal}

clear

echo "--------------------------------------------------------------
QUIRINUX PRO: COMPILAR E INSTALAR OPENTOONZ
--------------------------------------------------------------
  ___                 _____                     
 / _ \ _ __   ___ _ _|_   _|__   ___  _ __  ____
| | | | '_ \ / _ \ '_ \| |/ _ \ / _ \| '_ \|_  /
| |_| | |_) |  __/ | | | | (_) | (_) | | | |/ / 
 \___/| .__/ \___|_| |_|_|\___/ \___/|_| |_/___|
      |_|

Descargar código fuente e instalar compilando desde el código
la versión más nueva del programa de animación profesional 
OpenToonz con el que puedes reemplazar a Toon Boom Harmony.

Compatible con Debian Buster, Devuan Beowulf y Ubuntu 20.4

1 Descargar, compilar e instalar OpenToonz
0 Salir



"

read -p "Tu respuesta-> " opc 

case $opc in

"1") 

clear

# Instala dependencias del instalador

sudo apt-get update -y
for paquetes_wget in wget git software-properties-common; do sudo apt-get install -y $paquetes_wget; done
sudo apt-get install -f -y
sudo apt-get autoremove --purge -y

# Instala dependencias de OpenToonz

sudo apt-get update -y
for paquetes_opentoonz in build-essential git cmake pkg-config libboost-all-dev qt5-default qtbase5-dev libqt5svg5-dev qtscript5-dev qttools5-dev qttools5-dev-tools libqt5opengl5-dev qtmultimedia5-dev libsuperlu-dev liblz4-dev libusb-1.0-0-dev liblzo2-dev libpng-dev libjpeg-dev libglew-dev freeglut3-dev libfreetype6-dev libjson-c-dev qtwayland5 libqt5multimedia5-plugins; do sudo apt-get install -y $paquetes_opentoonz; done
for paquetes_opentoonz2 in libmypaint-dev; do sudo apt-get install -y $paquetes_opentoonz2; done

# Descarga y compila el código fuente de OpenToonz

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

# Descarga y copia en ícono del menú de inicio

sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/FZz85jagrQLCjjB/download' -O /opt/opentoonz/opentoonz-icon.tar
sudo rm /opt/opentoonz/opentoonz
sudo tar -xf /opt/opentoonz/opentoonz-icon.tar -C /

# Creando comando de inicio

sudo chmod -R 775 /opt/opentoonz
sudo chown -R $USER /opt/opentoonz

FILE="/usr/local/bin/imagine2"

if [ -f "$FILE" ]; then

sudo rm /usr/local/bin/opentoonz
sudo mv /opt/opentoonz/bin/opentoonz /opt/opentoonz/bin/run-opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/bin/opentoonz
sudo chmod -R 4755 /usr/local/bin/opentoonz

else

sudo mv /opt/opentoonz/bin/opentoonz /opt/opentoonz/bin/run-opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/bin/opentoonz
sudo chmod -R 4755 /usr/local/bin/opentoonz

fi

clear

echo "--------------------------------------------------------------
INSTALACIÓN FINALIZADA CON ÉXITO
--------------------------------------------------------------
 
¡Felicidades! OpenToonz ya está en tu sistema y puedes
abrirlo yendo a ${bold}Aplicaciones > Gráficos > OpenToonz${normal} o desde 
la terminal con el comando ${bold}opentoonz${normal}


"

;;

"0")

exit 0

;; 

esac 
