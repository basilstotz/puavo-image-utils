#!/bin/sh

cd $(dirname $0)

if ! grep -q 10 /etc/issue.net; then exit 0;fi 

echo *****************************geary***************************************

#install
apt-get -y -t buster-backports install geary

