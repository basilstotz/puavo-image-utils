#!/bin/sh
cd $(dirname $0)

echo *****************************write***************************************

wget -O write-tgz http://www.styluslabs.com/download/write-tgz

mkdir -p /opt/Write/

if test -d Write; then rm -rf Write; fi

tar xzf write-tgz
cd Write

cp Write /opt/Write/.
cp *.ttf /opt/Write/.
cp Write144x144.png /usr/share/pixmaps/.
cp Write.desktop /usr/share/applications/.


rm write-tgz
rm -r Write




