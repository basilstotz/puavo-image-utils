#!/bin/sh

rm  ${1}_*

cd ${1}-0.1
dch -i
dpkg-buildpackage -uc -tc
