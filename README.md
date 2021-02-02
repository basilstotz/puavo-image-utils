# puavo-image-utils


This is collection of very simple and minimalistic tool  to modify/inspect/serve PuavoOS images easyly.

 
 #### puavo-img-tool

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

 
 #### puavo-img-live

```
usage: puavo-img-live IMAGE.img

       Opens IMAGE.img in qemu for inspection.
       When the qemu image does not exist, it
       will be build as IMAGE-inst.img .
```


#### puavo-img-repo

```
usage: puavo-img-repo IMAGE_DIR [MIRROR_DIR]

       Maintains a repository of all images from IMAGE_DIR
       in MIRROR_DIR. When MIRROR_DIR is not set it defaults to
       IMAGE_DIR/mirror .
```


It is not aimed  for production, it's rather used for hacking and testing. Use it at your own risk. 


This is work in (eternal) progress ...

## Quick Start

Install the puavo-img-utils:

```
$ wget https://github.com/basilstotz/puavo-image-utils/releases/download/v0.1-beta.35/puavo-image-utils_0.1-35_all.deb
$ sudo dpkg -i puavo-image-utils_0.1-35_all.deb
```

Run run the example patch with the image on your Puavo laptop do:

```
$ mkdir MYIMAGES && cd MYIMAGES
$ puavo-img-tool --sourceimage /images/ltsp.img --datadir /opt/puavo-img-utils/example/datadir
$ puavo-img-tool
```

To run your new image on a virtualized computer do:

```
$ puavo-image-live YOURNEIMAGE.img
```
And finally, this command take all the images in in MYIMAGES and builds a mirror, suitable to serve your images over the internet.

```
$ cd MYIMAGES
$ puavo-img-repo ./
```
You just can add or remove images. Run `puavo-img-repo` again, and your mirror will be updated.



## A Closer Look at **puavo-img-tool**



### Basic Interactive Usage

```
sudo puavo-img-tool puavo-os-extra-buster-2021-01-25-220739-amd64.img
```
This command opens an interactive shell session on *puavo-os-extra-buster-2021-01-25-220739-amd64.img* with full read/write access. 

When you exit the chroot with a zero exit code a new image build including the possible modifications you made in the chroot. The puavo-on-imsge name will something like *puavo-os-extra-buster-2021-XX-XX-XXXXXX-amd64.img*.

- The time field in of the output name will reflect the build date and time.
- Exiting with non zero exit code skips the image generation.



### Advanced Automated Usage

When the datadir contains (at least one of) folder(s) whit names **pre.d**, **bin.d**, **files.d**, **lists.d**, **debs.d**, **parts.d** they are automatacilly handeld by the builtin chroot script. 

1. Copies the content of DATADIR to the chroot
2. Runs all executeables in **pre.d/\*.sh** , just before entering the chroot, in alphabetical order.
3. Enters chroot
4.    Runs all executeables in **bin.d/\*.sh** in alphabetical order. 
5.    Installs the file tree in **files.d/\*** to the root directory **/**
6.    Installs (with apt) all debs, which are contained in whitespace separated list files in **lists.d/\*.list**
7.    Installs all local debs in **debs.d/\*.deb**. All dependencies are resolved at the end.
8.    Executes all parts (or snippets) in **parts.d/\<partname\>/install.sh**.  
8. Exits chroot
9. Builds new PuavoOS image

In **/opt/puavo-image-utils/example/datadir** you'll find a working example datadir. I does (among other things):

- install  the local package `puavo-image-utils_0.1-XX_all.deb'
- install the file `puavo-hello-world` in `/usr/sbin/puavo-hello-world`
- install `gnome-maps` with `apt-get`
- make a new category `Meine Programme` in the puavo menu, containing all newly installed gui apps. 

###### More About Parts

Parts are mainly used to install/modify things "outside" of Debian.

- Parts are simple directories, which just **must** contain an executeable **install.sh** in (ba)sh. 
- The individual install.sh **can** either download things (during install in chroot) and/or **can** use content enbedded in the directory.

#### Example Parts
In the directory **/opt/puavo-image-utils/example/more-parts** you find some examples for parts. Move items to **parts.d/** in order to activate them.

- **cafepitch** a Markdown-driven presentation tool built on Electron. https://github.com/joe-re/cafe-pitch
- **geary** installs a newer geary - a Gnome3 integrated email client - from buster-packports debian repository
- **gedit-markdown**  adds support for Markdown language in gedit https://github.com/jpfleury/gedit-markdown
- **lumi**  is a desktop app that allows you to create, edit and view H5P (https://h5p.org) content. https://next.lumi.education/
- **markdown-cli** a collection of markdown cli tools. See install.sh for detials
- **obs-studio** updates to latest 26.01 version (self compiled) obs-studo (https://github.com/obsproject/obs-studio) and adds obs-rtspserver (https://github.com/iamscottxu/obs-rtspserver) and obs-websocket (https://github.com/Palakis/obs-websocket) plugins.
- **sozi** is a cool zooming presentation editor and player. https://sozi.baierouge.fr/
- **syncthing** is a continuous  peer-to-peer file synchronization program  https://syncthing.net/

Note that these examples are just dirty hacks (,which work for me).


## Usefull Links

Background knowledge about PuavoOS and PuavoOS-images:

- More information https://puavo.org and source code https://github.com/puavo-org
- An introduction to image Puavo image building and patching in general (in german): https://hackmd.io/lliTWflmTiSJ3zmLddRCaA
- Setup an Puavo image repostory (in german too):  https://hackmd.io/gdqd7gnpTSKORQEyW5y1EA
- An general introduction to the Puavo ICT environment for schools (in german): https://hackmd.io/D1U0ywlLSva94FMxy3hGSg 
- An introduction to PuavoOS, a Debian based OS for schools (in german): https://hackmd.io/519PnTRuSbaK-tCxs5eIrw
