#/bin/sh
cd $(dirname $0)

APP="Lumi-0.4.0.AppImage"

if ! test -d /opt/lumi/; then
   mkdir -p /opt/lumi/
fi

if ! test -f $APP; then
    wget  https://github.com/Lumieducation/Lumi/releases/download/v0.4.0/$APP
fi

cp ./$APP /opt/lumi/Lumi.AppImage
chmod +x /opt/lumi/Lumi.AppImage

cp ./lumi.png /usr/share/pixmaps/.

