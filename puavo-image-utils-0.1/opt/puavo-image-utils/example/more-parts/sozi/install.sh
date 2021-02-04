#/bin/sh

cd $(dirname $0)

#download and unpack
if ! test -f sozi_20.05.09-1589035558_amd64.deb ;then
   wget https://github.com/sozi-projects/Sozi/releases/download/v20.05/sozi_20.05.09-1589035558_amd64.deb 
fi

#install
dpkg -i sozi_20.05.09-1589035558_amd64.deb 
cp sozi.desktop  /usr/share/applications/.







