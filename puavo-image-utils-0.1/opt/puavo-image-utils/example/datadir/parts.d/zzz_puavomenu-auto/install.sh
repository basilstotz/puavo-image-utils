#!/bin/sh

cd $(dirname $0)

# make-auto-menu.sh need a proramm started at teh very beginning of the
# installation:

# $ ls /usr/share/applications/ > /tmp/applications.list

# here this is done with bin.d/make-auto-menu-init.sh


./make-menu-auto.sh > /etc/puavomenu/menudata/80-auto.json

