#!/bin/sh

# **********************************************************************************
# ********               wireguard ************************************************
#**********************************************************************************
cd $(dirname $0)

#if ! grep -q 10 /etc/issue.net; then exit 0;fi 

echo *****************************gedit-markdown***************************************

if ! test -d gedit-plugin-markdown_preview; then
    git clone https://github.com/maoschanz/gedit-plugin-markdown_preview
fi

cd gedit-plugin-markdown_preview
./install
