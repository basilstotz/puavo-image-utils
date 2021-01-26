# puavo-img-tool

This a very simple and minimalistic programm aimed to easyly patch PuavoOS images. 

Some background knowledge about PuavoOS images:

- An introduction to image Puavo image building and patching in general (in german): https://hackmd.io/lliTWflmTiSJ3zmLddRCaA
- Setup an Puavo image repostory (in german too):  https://hackmd.io/gdqd7gnpTSKORQEyW5y1EA

This is work in (eternal) progress ...

## Quick Start

- clone this repo **git clone https://github.com/basilstotz/puavo-img-tool.git**
- edit **puavo-img-patch.sh** to set source puavo-os-image. 
- **sudo make**
- wait for patch process to be finished
- install the new image on your Puavo latop with **sudo puavo-install-and-update-image -f NEWIMAGENAME.img  NEWIMAGENAME.img**

## The puavo-img-tool

```
Usage: sudo puavo-img-tool [options] [/path/to/]IMAGE.img

Inspect or modify a PuavoOS image and (optionaly) create a new puavo-os image

Options:
    -c, --class  CLASS     set image class to CLASS (defaults to source class)
    -o, --osname OSNAME    set image osname to OSNAME (defaults to source osname)
    -d, --datadir DATADIR  copies the content of datadir to /install/ in the chroot.
    -f, --force            force image creation even with errors
    -i, --iteractive       force interactive shell
    -h, --help             show this help message
```
(The Makefile here included is just a wrapper around **puavo-img-tool**)


## Basic Interactive Usage

Hint: Be shure to have sudo rights and run **sudo make install** to (temporaly ) install the puavo-img-tools on your system. (Not needed with **make**.)

```
sudo puavo-img-tool puavo-os-extra-buster-2021-01-25-220739-amd64.img
```
This command opens an interactive shell session on *puavo-os-extra-buster-2021-01-25-220739-amd64.img* with full read/write access. 

When you exit the chroot with a zero exit code a new image build including the possible modifications you made in the chroot. The puavo-on-imsge name will something like *puavo-os-extra-buster-2021-XX-XX-XXXXXX-amd64.img*.

- The time field in of the output name will reflect the build date and time.
- Exiting with non zero exit code skips the image generation.

```
sudo puavo-img-tool --datadir /path/to/datadir puavo-os-extra-buster-2021-01-25-220739-amd64.img
```
This command is similar to the above, but it copies the content of **/path/to/datadir/\*** to your chroot in **/install/** bevor entering the interactive shell.

The **/install** directory (in chroot) will be removed bevor compressing the image.

```
sudo puavo-img-tool --osname amxa --class spezial puavo-os-extra-buster-2021-01-25-220739-amd64.img
```
This command is similar to the first one, but it changes the name of the image. The output will be something like "**amxa**-os-**spezial**-buster-2021-XX-XX-XXXXXX-amd64.img".


## Advanced Automated Usage

When the datadir contains (at least one of) folder(s) whit names **bin.d**, **files.d**, **lists.d**, **debs.d**, **parts.d** the programm switches to non interacitve mode. All other dirs are just ignored.

The the non interactice process in the chroot is controlled by the content of these directories:

1. It runs all executeables in **bin.d/\*.sh** in alphabetical order. 
2. Installs the file tree in **files.d/\*** to the root directory **/**
3. Installs (with apt) all debs, which are contained in whitespace separated list files in **lists.d/\*.list**
4. Installs all local debs in **debs.d/\*.deb**. All dependencies are resolved at the end.
5. Executes all parts (or snippets) in **parts.d/\<partname\>/install.sh**.  

If no errors are detected a new puavo-os will bei built. 

- Use option ---force to force image creation even with errors
- Use the option --interactive to force an interactice shell
- if you only use only the bin.d directory (and no debs.d, .., etc), you can put your own freestyle and use own chroot script instead of the builtin one. 

## More About Parts

Parts are mainly used to install/modify things "outside" of Debian.

- Parts are simple directories, which just **must** contain an executeable **install.sh** in (ba)sh. 
- The individual install.sh **can** either download things (during install in chroot) and/or **can** use content enbedded in the directory.

#### Example Parts
In the directory **partsonstock** you find some examples for parts. Move items to **install/parts/** in order to activate them.

- **cafepitch** a Markdown-driven presentation tool built on Electron. https://github.com/joe-re/cafe-pitch
- **geary** installs a newer geary - a Gnome3 integrated email client - from buster-packports debian repository
- **gedit-markdown**  adds support for Markdown language in gedit https://github.com/jpfleury/gedit-markdown
- **lumi**  is a desktop app that allows you to create, edit and view H5P (https://h5p.org) content. https://next.lumi.education/
- **markdown-cli** a collection of markdown cli tools. See install.sh for detials
- **obs-studio** updates to latest 26.01 version (self compiled) obs-studo (https://github.com/obsproject/obs-studio) and adds obs-rtspserver (https://github.com/iamscottxu/obs-rtspserver) and obs-websocket (https://github.com/Palakis/obs-websocket) plugins.
- **sozi** is a cool zooming presentation editor and player. https://sozi.baierouge.fr/
- **syncthing** is a continuous  peer-to-peer file synchronization program  https://syncthing.net/

Note that these examples are just dirty hacks (,which work for me).


#### Some hints for PuavoOS

- The part **parts.d/puavo-menu** must always reflect the changes/additions you made to the image in order to be accessible on the Puavo desktop. 
- On PuavoOs laptops you can test the part by executing (as root) the **parts.d/\<partname\>/install.sh** on live your laptop.


## About Puavo

- See https://puavo.org and https://github.com/puavo-org
- An general introduction to the Puavo ICT environment for schools (in german): https://hackmd.io/D1U0ywlLSva94FMxy3hGSg 
- An introduction to PuavoOS, a Debian based OS for schools (in german): https://hackmd.io/519PnTRuSbaK-tCxs5eIrw
