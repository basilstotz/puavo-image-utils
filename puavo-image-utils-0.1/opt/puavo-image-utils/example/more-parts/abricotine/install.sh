#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    wget https://github.com/brrd/abricotine/releases/download/1.0.0/abricotine-1.0.0-ubuntu-debian-x64.deb
fi


#install
dpkg -i *.deb   
