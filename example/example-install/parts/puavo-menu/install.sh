#!/bin/sh

cd $(dirname $0)

cp ./pixmaps/* /usr/share/pixmaps/.

if cat /etc/issue|grep -q 9; then
    echo "puavomenu stretch"
    cp 90-amxa.yml /etc/puavomenu/menudata/.
else
    echo "puavomenu buster"
    cp 90-amxa.json /etc/puavomenu/menudata/.
    #    cp menudata_loader.py /opt/puavomenu/loaders/.
fi

