#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
fi


#install
dpkg -i *.deb   
