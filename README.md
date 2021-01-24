# puavo-patch-generic

This a simple minimalistic "framework" aimed to patch PuavoOS images. It work in (eternal) progress ...

## Quick Start

- clone this repo 
- copy a PuavoOs image to the directory **opinsys**
- as root type **make**
- wait for patch process to be finished
- install the new image on your Puavo latop (or put it in cloud image repository)

## Add Your Own Things

The patch process is controlled by the content of the directories inside the directory **install**. Modify them after your needs.

- installs the file tree in **install/files/\*** to the root directory **/**
- installs (with apt) all debs, which are contained in whitespace separated list files in **install/lists/*.list**
- installs all local debs in **install/debs/*.deb**. All dependencies are resolved at the end.
- executes all snippets in **install/parts/\<partname\>/install.sh**. You can do anything here. Have a look at the example parts.

The part **install/parts/puavo-menu** must always reflect the changes/additions you made to the image in order to be accessible on the Puavo desktop. 

## What could go wrong?

The patch process needs (up to 10 GBytes) temporary disk space in the partition **/images/**. Be shure there is enough space there or see **./bin/puavo-img-mount --help** and patch **bin/puavo-img-patch** accordingly
