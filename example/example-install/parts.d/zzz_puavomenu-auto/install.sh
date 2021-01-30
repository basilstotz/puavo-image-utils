#!/bin/sh

cd $(dirname $0)

./make-auto-menu.sh > /etc/puavomenu/menudata/80-auto.json

