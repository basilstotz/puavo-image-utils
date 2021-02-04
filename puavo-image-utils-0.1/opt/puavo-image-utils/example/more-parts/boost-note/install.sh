#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    wget https://github.com/BoostIO/BoostNote.next/releases/latest/download/boost-note-linux.deb
fi


#install
dpkg -i *.deb   
