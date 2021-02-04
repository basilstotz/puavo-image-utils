#!/bin/sh

echo "************************* typora **********************************"
cd $(dirname $0)


#download and unpack
if test -z "$(ls|grep .deb)";then
    echo "downloading ..." 1>&2
    # sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
    wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
    # add Typora's repository
    echo 'deb https://typora.io/linux ./' > /etc/apt/sources.list.d/typora.list
    apt-get -y update
    apt-get -y download typora
    rm /etc/apt/sources.list.d/typora.list
fi


#install 
dpkg -i *.deb







