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


1 Descargar, compilar e instalar OpenToonz 1.4 (estable)
2 Descargar, compilar e instalar OpenToonz nightly build (testing)
0 Salir

"

read -p "Tu respuesta-> " opc 

case $opc in

"1") 

clear

# Instala dependencias del instalador de OpenToonz

sudo apt-get update -y
for paquetes_wget in wget git software-properties-common; do sudo apt-get install -y $paquetes_wget; done
sudo apt-get install -f -y
sudo apt-get autoremove --purge -y

# Instala dependencias de OpenToonz

sudo apt-get update -y
for paquetes_opentoonz in build-essential git cmake pkg-config libboost-all-dev qt5-default qtbase5-dev libqt5svg5-dev qtscript5-dev qttools5-dev qttools5-dev-tools libqt5opengl5-dev qtmultimedia5-dev libsuperlu-dev liblz4-dev libusb-1.0-0-dev liblzo2-dev libpng-dev libjpeg-dev libglew-dev freeglut3-dev libfreetype6-dev libjson-c-dev qtwayland5 libqt5multimedia5-plugins; do sudo apt-get install -y $paquetes_opentoonz; done
for paquetes_opentoonz2 in libmypaint-dev; do sudo apt-get install -y $paquetes_opentoonz2; done

# Descarga y compila el código fuente de OpenToonz

mkdir -p /opt/tmp/opentoonz
sudo wget  --no-check-certificate 'https://github.com/opentoonz/opentoonz/archive/v1.4.0.tar.gz' -O /opt/tmp/opentoonz/opentoonz-1.4.0.tar.gz
tar -xzvf /opt/tmp/opentoonz/opentoonz-1.4.0.tar.gz -C /opt/tmp/
cd /opt/tmp/opentoonz-1.4.0
mkdir -p $HOME/.config/OpenToonz
cp -r /opt/tmp/opentoonz-1.4.0/stuff $HOME/.config/OpenToonz/
cat << EOF > $HOME/.config/OpenToonz/SystemVar.ini
[General]
OPENTOONZROOT="$HOME/.config/OpenToonz/stuff"
OpenToonzPROFILES="$HOME/.config/OpenToonz/stuff/profiles"
TOONZCACHEROOT="$HOME/.config/OpenToonz/stuff/cache"
TOONZCONFIG="$HOME/.config/OpenToonz/stuff/config"
TOONZFXPRESETS="$HOME/.config/OpenToonz/stuff/projects/fxs"
TOONZLIBRARY="$HOME/.config/OpenToonz/stuff/projects/library"
TOONZPROFILES="$HOME/.config/OpenToonz/stuff/profiles"
TOONZPROJECTS="$HOME/.config/OpenToonz/stuff/projects"
TOONZROOT="$HOME/.config/OpenToonz/stuff"
TOONZSTUDIOPALETTE="$HOME/.config/OpenToonz/stuff/studiopalette"
EOF
cd /opt/tmp/opentoonz-1.4.0/thirdparty/tiff-4.0.3 
./configure --with-pic --disable-jbig
make -j$(nproc)
cd ../../
cd toonz
mkdir build
cd build
cmake ../sources
make -j$(nproc)
sudo make install 
sudo apt-get install -f -y
sudo apt-get autoremove --purge -y

# Descarga y copia el ícono del menú de inicio de OpenToonz

sudo mv /opt/opentoonz/bin/opentoonz /opt/opentoonz/bin/opentoonz2
sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/FZz85jagrQLCjjB/download' -O /opt/tmp/opentoonz/opentoonz-icon.tar
sudo mv /opt/tmp/opentoonz /opt/tmp/opentoonz-tmp
sudo tar -xvf /opt/tmp/opentoonz-tmp/opentoonz-icon.tar -C /
mv /opt/tmp/opentoonz /opt/opentoonz/opentoonz
cp -r /opentoonz-icon/* /
rm -r /opentoonz-icon/

# Creando comando de inicio de OpenToonz

sudo chmod -R 775 /opt/opentoonz
sudo chown -R $USER /opt/opentoonz

FILE="/usr/local/bin/opentoonz"

if [ -f "$FILE" ]; then

sudo rm /usr/local/bin/opentoonz
mv /opt/tmp/opentoonz-tmp/* /opt/opentoonz/bin/opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/opentoonz
sudo chmod 777 /usr/local/bin/opentoonz

else

mv /opt/tmp/opentoonz-tmp/* /opt/opentoonz/bin/opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/opentoonz
sudo chmod 777 /usr/local/bin/opentoonz

fi

# Borrar archivos temporales

sudo rm -rf /opt/tmp/*
sudo rm /opt/opentoonz/opentoonz-icon.tar

clear

echo "--------------------------------------------------------------
INSTALACIÓN FINALIZADA CON ÉXITO
--------------------------------------------------------------
 
¡Felicidades! OpenToonz Estable 1.4 ya está en tu sistema y puedes
abrirlo yendo a ${bold}Aplicaciones > Gráficos > OpenToonz${normal} o desde 
la terminal con el comando ${bold}opentoonz${normal}
"

exit 0

;;

"2")

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

# Descarga y copia el ícono del menú de inicio de OpenToonz

sudo mv /opt/opentoonz/bin/opentoonz /opt/opentoonz/bin/opentoonz2
sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/FZz85jagrQLCjjB/download' -O /opt/tmp/opentoonz/opentoonz-icon.tar
sudo mv /opt/tmp/opentoonz /opt/tmp/opentoonz-tmp
sudo tar -xvf /opt/tmp/opentoonz-tmp/opentoonz-icon.tar -C /
mv /opt/tmp/opentoonz /opt/opentoonz/opentoonz
cp -r /opentoonz-icon/* /
rm -r /opentoonz-icon/

# Creando comando de inicio de OpenToonz

sudo chmod -R 775 /opt/opentoonz
sudo chown -R $USER /opt/opentoonz

FILE="/usr/local/bin/opentoonz"

if [ -f "$FILE" ]; then

sudo rm /usr/local/bin/opentoonz
mv /opt/tmp/opentoonz-tmp/* /opt/opentoonz/bin/opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/opentoonz
sudo chmod 777 /usr/local/bin/opentoonz

else

mv /opt/tmp/opentoonz-tmp/* /opt/opentoonz/bin/opentoonz
cd /usr/local/bin
sudo ln -s /opt/opentoonz/opentoonz
sudo chmod 777 /usr/local/bin/opentoonz

fi

clear

echo "--------------------------------------------------------------
INSTALACIÓN FINALIZADA CON ÉXITO
--------------------------------------------------------------
 
¡Felicidades! OpenToonz Testing ya está en tu sistema y puedes
abrirlo yendo a ${bold}Aplicaciones > Gráficos > OpenToonz${normal} o desde 
la terminal con el comando ${bold}opentoonz${normal}
"

exit 0

;;

"0")

clear

exit 0

;; 

esac 
