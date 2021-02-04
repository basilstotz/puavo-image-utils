#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    echo "deb https://apt.syncthing.net/ syncthing stable" > /etc/apt/sources.list.d/syncthing.list
    curl -s https://syncthing.net/release-key.txt | apt-key add -
    apt-get update
    apt-get -y download syncthing-gtk
    rm /etc/apt/sources.list.d/syncthing.list
fi


#install
dpkg -i *.deb   
