#!/bin/sh

cd $(dirname $0)

# this needs a proramm started at the very beginning of the
# installation:

# here this is done with bin.d/puavomenu-auto-init.sh


./generate-menu.sh > /etc/puavomenu/menudata/80-auto.json

