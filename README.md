# puavo-image-utils


This a very simple and minimalistic programm to patch/inspect PuavoOS images easyly. It is not aimed  for production, it's rather used for hacking and testing. Use it at your own risk. 


This is work in (eternal) progress ...

## Quick Start

Install the puavo-img-utils

```
$ wget https://github.com/basilstotz/dfsadffsdfsadfasdf/dfsdasd.deb
$ sudo dpkg -i sdfsdfsd.deb
```
Now you ....

```
$ mkdir MYIMAGES && cd MYIMAGES
$ puavo-img-tool --sourceimage /images/ltsp.img --datadir /opt/puavo-img-utils/example/datadir
$ sudo puavo-img-tool
```
sdfsdfsdaf sdfsd fsdf sdf f

```
$ puavo-image-live YOURNEIMAGE.img
```
sd sadfasdf sdf

```
$ cd MYIMAGES
$ puavo-img-repo ./
```

cxyvxycvxycvyxcy  xcvxcv cxyv

## A Closer Look at the Tools

### puavo-img-tool

```
Usage: puavo-img-tool [config_opts]      (configure)
       puavo-img-tool IMAGE.img          (interactive)
       puavo-img-tool [runtime_opts]     (batch)

Patch a PuavoOS image and (eventualy) compress a new image.

Config options:
    -s, --source SOURCE        set source to SOURCE
    -d, --datadir DATADIR      set datadir to DATADIR
    -o, --osname OSNAME        set image osname to OSNAME
    -c, --class CLASS          set image class to CLASS
    -h, --help                 show this help

 Stored params are:
      source: 
     datadir: 
      osname: 
       class: 

Runtime options:
    -i, --interactice          force interactive shell
    -f, --force                force building image even with errors
    -n, --noimage              do not build image even without errors
    -y, --yes                  do not ask at start
    -q, --qemu                 do also make a qemu image

```


###### Basic Interactive Usage

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


###### Advanced Automated Usage

When the datadir contains (at least one of) folder(s) whit names **bin.d**, **files.d**, **lists.d**, **debs.d**, **parts.d** the programm switches to non interacitve mode. Other dirs can be here too, but are just ignored by the builtin chroot script.

The the non interactice process in the chroot is controlled by the content of these directories:

1. It runs all executeables in **bin.d/\*.sh** in alphabetical order. 
2. Installs the file tree in **files.d/\*** to the root directory **/**
3. Installs (with apt) all debs, which are contained in whitespace separated list files in **lists.d/\*.list**
4. Installs all local debs in **debs.d/\*.deb**. All dependencies are resolved at the end.
5. Executes all parts (or snippets) in **parts.d/\<partname\>/install.sh**.  

In **example/example-install** you'll find a working example datadir.

- If errors are detected during execution in chroot, the building of the new image will be skipped. 
- Use option ---force to force image creation even with errors
- Use the option --interactive to force an interactice shell
- Hint: If you only use only the bin.d directory (and no debs.d, .., etc), you can put your own freestyle chroot script and use this ine instead of the builtin. 

###### More About Parts

Parts are mainly used to install/modify things "outside" of Debian.

- Parts are simple directories, which just **must** contain an executeable **install.sh** in (ba)sh. 
- The individual install.sh **can** either download things (during install in chroot) and/or **can** use content enbedded in the directory.

#### Example Parts
In the directory **example/more-parts** you find some examples for parts. Move items to **parts.d/** in order to activate them.

- **cafepitch** a Markdown-driven presentation tool built on Electron. https://github.com/joe-re/cafe-pitch
- **geary** installs a newer geary - a Gnome3 integrated email client - from buster-packports debian repository
- **gedit-markdown**  adds support for Markdown language in gedit https://github.com/jpfleury/gedit-markdown
- **lumi**  is a desktop app that allows you to create, edit and view H5P (https://h5p.org) content. https://next.lumi.education/
- **markdown-cli** a collection of markdown cli tools. See install.sh for detials
- **obs-studio** updates to latest 26.01 version (self compiled) obs-studo (https://github.com/obsproject/obs-studio) and adds obs-rtspserver (https://github.com/iamscottxu/obs-rtspserver) and obs-websocket (https://github.com/Palakis/obs-websocket) plugins.
- **sozi** is a cool zooming presentation editor and player. https://sozi.baierouge.fr/
- **syncthing** is a continuous  peer-to-peer file synchronization program  https://syncthing.net/

Note that these examples are just dirty hacks (,which work for me).

- The part **parts.d/puavo-menu** must always reflect the changes/additions you made to the image in order to be accessible on the Puavo desktop. 
- On PuavoOs laptops you can test the part by executing (as root) the **parts.d/\<partname\>/install.sh** on live your laptop.

### puavo-img-live

### puavo-img-repo




## Usefull Links

Background knowledge about PuavoOS and PuavoOS-images:

- More information https://puavo.org and source code https://github.com/puavo-org
- An introduction to image Puavo image building and patching in general (in german): https://hackmd.io/lliTWflmTiSJ3zmLddRCaA
- Setup an Puavo image repostory (in german too):  https://hackmd.io/gdqd7gnpTSKORQEyW5y1EA
- An general introduction to the Puavo ICT environment for schools (in german): https://hackmd.io/D1U0ywlLSva94FMxy3hGSg 
- An introduction to PuavoOS, a Debian based OS for schools (in german): https://hackmd.io/519PnTRuSbaK-tCxs5eIrw
