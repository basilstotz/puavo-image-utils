#!/bin/sh

cd $(dirname $0)

#if ! grep -q 10 /etc/issue.net; then exit 0;fi

echo *****************************wireguard***************************************

#downlad and unpack
if ! test -e CafePitch-linux-x64.zip; then
    wget https://github.com/joe-re/cafe-pitch/releases/download/0.1.2/CafePitch-linux-x64.zip
fi



#install 
if ! test -d /opt/cafepitch;then
    mkdir -p /opt/cafepitch
fi

if ! test -e /opt/cafepitch/CafePitch; then
   unzip -d /opt/cafepitch CafePitch-linux-x64.zip >/dev/null
fi

chmod +x /opt/cafepitch/CafePitch

cp ./cafepitch.png /usr/share/pixmaps/cafepitch.png
cp ./cafepitch.desktop /usr/share/applications/cafepitch.desktop

