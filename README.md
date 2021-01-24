# puavo-patch-generic

This a simple minimalistic "framework" aimed to easyly patch PuavoOS images. 

Some background knowledge about PuavoOS images:

- An introduction to image Puavo image building and patching in general (in german): https://hackmd.io/lliTWflmTiSJ3zmLddRCaA
- Setup an Puavo image repostory (in german too):  https://hackmd.io/gdqd7gnpTSKORQEyW5y1EA

This is work in (eternal) progress ...

## Quick Start

- clone this repo 
- copy a PuavoOs image to the directory **opinsys**. (If there is more than one image, the newest is taken.)
- as root type **make**
- wait for patch process to be finished
- install the new image on your Puavo latop (or put it in cloud image repository)

## Add Your Own Things

The patch process is controlled by the content of the directories inside the directory **install**. Modify them after your needs.

- installs the file tree in **install/files/\*** to the root directory **/**
- installs (with apt) all debs, which are contained in whitespace separated list files in **install/lists/*.list**
- installs all local debs in **install/debs/*.deb**. All dependencies are resolved at the end.
- executes all snippets in **install/parts/\<partname\>/install.sh**.  

### Parts

- You can do anything here. Have a look at the example parts.
- The part **install/parts/puavo-menu** must always reflect the changes/additions you made to the image in order to be accessible on the Puavo desktop. 
- Hint: On PuavoOs laptops you can test the part by executing (as root) the **install/parts/\<partname\>/install.sh** on your laptop.

## How does it work?

The patch process is done by the programm **bin/puavo-img-patch**, which uses some helper programms:  

- The main is **bin/puavo-img-mount**. This programm mounts a (readonly) squashfs image in read/write mode! 
- Then the programm **bin/puavo-dir-chroot** executs **install/bin/puavo-chroot-apply** in chroot. 
- The patched image then will be compressed again as squashfs with **bin/puavo-dir-clone**. 
- In order to speed up thing the downloaded debs are cached in the directory **cache**.

## What could go wrong?

The patch process needs (up to 10 GBytes) temporary disk space in the partition **/images/**. Be shure there is enough space there or see **./bin/puavo-img-mount --help** and patch **bin/puavo-img-patch** accordingly

## About Puavo

- See https://puavo.org and https://github.com/puavo-org
- An general introduction to the Puavo ICT environment for schools (in german): https://hackmd.io/D1U0ywlLSva94FMxy3hGSg 
- An introduction to PuavoOS, a Debian based OS for schools (in german): https://hackmd.io/519PnTRuSbaK-tCxs5eIrw
