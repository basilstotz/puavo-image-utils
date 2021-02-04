#!/bin/sh
cd $(dirname $0)

echo *****************************write***************************************

#download and unpack
if ! test -d Write;then
     test -f write.tgz || wget -O write-tgz http://www.styluslabs.com/download/write-tgz
     tar xzf write-tgz
     rm write-tgz
fi

#install
mkdir -p /opt/Write/
cd Write
cp Write /opt/Write/.
cp *.ttf /opt/Write/.
cp Write144x144.png /usr/share/pixmaps/.
cp Write.desktop /usr/share/applications/.






