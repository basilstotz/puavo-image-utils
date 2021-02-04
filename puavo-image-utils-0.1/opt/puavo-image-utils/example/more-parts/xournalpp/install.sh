#/bin/sh
cd $(dirname $0)


#download and unpack

if test -z "$(ls|grep .deb)";then
    wget https://github.com/xournalpp/xournalpp/releases/download/1.0.20-hotfix/xournalpp-1.0.20-hotfix-hotfix-Debian-buster-x86_64.deb
fi


#install
dpkg -i *.deb   
