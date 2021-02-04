#!/bin/sh

cd $(dirname $0)

#if ! grep -q 10 /etc/issue.net; then exit 0;fi 

echo *****************************markdown-cli***************************************

#download and unpack
if ! test -e marp; then
    wget https://github.com/marp-team/marp-cli/releases/download/v0.23.0/marp-cli-v0.23.0-linux.tar.gz && \
    tar -xzf marp-cli-v0.23.0-linux.tar.gz
fi
if ! test -e deck; then
    wget https://github.com/fdehau/deck/releases/download/v0.3.0/deck-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf deck-x86_64-unknown-linux-gnu.tar.gz
fi

#install 
apt-get -y install darkslide mdp pdfpc

cp marp /usr/local/bin/.
cp deck /usr/local/bin/.



