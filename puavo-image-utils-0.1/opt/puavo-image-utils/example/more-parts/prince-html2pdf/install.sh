#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    wget https://www.princexml.com/download/prince_14-1_debian10_amd64.deb
fi


#install
dpkg -i *.deb   
