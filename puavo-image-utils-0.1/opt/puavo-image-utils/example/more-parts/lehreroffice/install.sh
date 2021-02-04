#/bin/sh
cd $(dirname $0)


#download and unpack
if ! test -f lo_desktop_linux_64bit.tgz;then
    wget -O  lo_desktop_linux_64bit.tgz https://www.lehreroffice.ch/lo/dateien/easy/lo_desktop_linux_64bit.tgz
fi




#install
test -d /opt/lehreroffice || mkdir -p /opt/lehreroffice

tar -xzf lo_desktop_linux_64bit.tgz -C /opt/lehreroffice/ 
chmod +x /opt/lehreroffice/LehrerOffice

cp lehreroffice.desktop /usr/share/applications/.
cp lehreroffice /usr/local/bin/.
cp lehreroffice.png /usr/share/pixmaps/.
   
