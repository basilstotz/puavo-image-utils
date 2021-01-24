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

### Parts?

- Parts are simple directories, 
- which **must** contain an executeable **install.sh** in (ba)sh. 
- The individual install.sh **can** either download things (during install in chroot) and/or **can** use content enbedded in the directory.

#### Example Parts
In the directory **partsonstock** you find some examples for parts. Move items to **install/parts/** in order to activate them.

- **cafepitch** a Markdown-driven presentation tool built on Electron. https://github.com/joe-re/cafe-pitch
- **geary** installs a newer geary - a Gnome3 integrated email client - from buster-packports debian repository
- **gedit-markdown**  adds support for Markdown language in gedit https://github.com/jpfleury/gedit-markdown
- **lumi**  is a desktop app that allows you to create, edit and view H5P (https://h5p.org) content. https://next.lumi.education/
- **markdown-cli** a collection of markdown cli tools. See install.sh for detials
- **sozi** is a cool zooming presentation editor and player. https://sozi.baierouge.fr/
- **syncthing** is a continuous  peer-to-peer file synchronization program  https://syncthing.net/

Note that these examples are just dirty hacks (,which work for me).


#### Some hints for PuavoOS

- The part **install/parts/puavo-menu** must always reflect the changes/additions you made to the image in order to be accessible on the Puavo desktop. 
- On PuavoOs laptops you can test the part by executing (as root) the **install/parts/\<partname\>/install.sh** on live your laptop.

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
