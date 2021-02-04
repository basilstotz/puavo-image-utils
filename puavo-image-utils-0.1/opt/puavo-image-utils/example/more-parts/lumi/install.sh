#/bin/sh
cd $(dirname $0)

VERSION="0.5.0"

APP="Lumi-$VERSION.AppImage"

#downlaod and unpack
if ! test -f $APP; then
    wget  https://github.com/Lumieducation/Lumi/releases/download/v$VERSION/$APP
fi

#install
if ! test -d /opt/lumi/; then
   mkdir -p /opt/lumi/
fi
cp ./$APP /opt/lumi/Lumi.AppImage
chmod +x /opt/lumi/Lumi.AppImage
cp ./lumi.png /usr/share/pixmaps/.

