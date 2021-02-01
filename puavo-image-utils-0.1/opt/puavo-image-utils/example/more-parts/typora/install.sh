#!/bin/sh

echo "************************* package nightly-updates **********************************"
cd $(dirname $0)

# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE

wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -

# add Typora's repository

echo 'deb https://typora.io/linux ./' > /etc/apt/sources.list.d/typora.list
 
apt-get -y update

# install typora

apt-get -y install typora







