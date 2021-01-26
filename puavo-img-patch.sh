#!/bin/sh

#you might want to edit these vars
OSNAME="puavo"
CLASS="extra"
SOURCE_IMAGE="./puavo-os-extra-buster-2021-01-25-220739-amd64.img"
DATAPATH="example/example-install/"

if ! test -e ${SOURCE_IMAGE};then
    echo "error: source image not found"
    echo
    echo "       you may want to edit puavo-img-patch.sh"

#install bins
cp bin/* /usr/local/bin/.

#call image tool
puavo-img-tool -d ${DATATPATH} -o ${OSNAME} -c ${CLASS} ${SOURCE_IMAGE}



