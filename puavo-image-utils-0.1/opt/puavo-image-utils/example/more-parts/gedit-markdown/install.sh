#!/bin/sh

cd $(dirname $0)

#if ! grep -q 10 /etc/issue.net; then exit 0;fi 

echo *****************************gedit-markdown***************************************

#download and unpack
if ! test -d gedit-plugin-markdown_preview; then
    git clone https://github.com/maoschanz/gedit-plugin-markdown_preview
fi

#install
cd gedit-plugin-markdown_preview
./install.sh

exit $?
