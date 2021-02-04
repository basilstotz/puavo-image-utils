#!/bin/sh

cd $(dirname $0)

if ! grep -q 10 /etc/issue.net; then exit 0;fi 

echo *****************************obs***************************************

# install and unpack

#latest obs-studio (self compiled)
if ! test -f obs-studio_20210107-git-1_amd64.deb;then
    wget https://www.amxa.ch/debian/packages/obs-studio_20210107-git-1_amd64.deb
fi
#plugin websocket
if ! test -e obs-websocket-4.8.0-1_amd64.deb;then
  wget https://github.com/Palakis/obs-websocket/releases/download/4.8.0/obs-websocket-4.8.0-1_amd64.deb
fi
#plugin rtspserver
if ! test -e obs-rtspserver-v1.2.1-linux.tar.gz;then 
    wget https://github.com/iamscottxu/obs-rtspserver/releases/download/v1.2.1/obs-rtspserver-v1.2.1-linux.tar.gz
fi


#install
apt-get -y remove obs-studio obs-plugins libobs0
test -d /usr/share/obs/obs-plugins/obs-rtspserver/ || mkdir -p /usr/share/obs/obs-plugins/obs-rtspserver/
tar -xzvf obs-rtspserver-v1.2.1-linux.tar.gz -C /usr/share/obs/obs-plugins/obs-rtspserver/
for D in *.deb; do
    dpkg -i $D
done
#apt-get -y -f install


