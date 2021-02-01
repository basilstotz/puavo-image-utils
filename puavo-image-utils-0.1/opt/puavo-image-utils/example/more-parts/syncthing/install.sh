#/bin/sh
cd $(dirname $0)

if ! test -d /etc/apt/sources.list.d/syncthing.list; then
    echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
fi

apt-get update

apt-get -y install syncthing-gtk
