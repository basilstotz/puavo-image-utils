#/bin/sh
cd $(dirname $0)

wget https://github.com/sozi-projects/Sozi/releases/download/v20.05/sozi_20.05.09-1589035558_amd64.deb 

dpkg -i sozi*deb


cp sozi.desktop  /usr/share/applications/.


rm *deb




