#!/bin/sh

cd $(dirname $0)

git clone https://github.com/basilstotz/puavo-img-tool.git
cd puavo-img-tool
cp ./bin/puavo-img-* /usr/local/bin/.


