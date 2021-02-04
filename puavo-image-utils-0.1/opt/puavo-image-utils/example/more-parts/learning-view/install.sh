#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    wget https://learningview.org/app/learning-view_amd64.deb
fi


#install
dpkg -i *.deb   
