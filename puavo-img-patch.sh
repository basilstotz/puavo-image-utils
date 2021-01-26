#!/bin/sh

#you might want to edit these vars
OSNAME="puavo"
CLASS="extra"
SOURCE_IMAGE="/home/stotz.basil/builder/stretch-builder/images/opinsys/opinsys-os-opinsys-buster-2020-12-09-114058-amd64.img"
#SOURCE_IMAGE="opinsys-os-opinsys-buster-2020-12-09-114058-amd64.img"
DATAPATH="./example/example-install/"

if ! test -e ${SOURCE_IMAGE};then
    echo "error: source image not found"
    echo
    echo "       you may want to edit puavo-img-patch.sh"
fi

#install bins
cp bin/* /usr/local/bin/.

#call image tool
puavo-img-tool --datadir ${DATAPATH} --osname ${OSNAME} --class ${CLASS} ${SOURCE_IMAGE}



