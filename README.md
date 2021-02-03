# puavo-image-utils

This is collection of very simple and minimalistic tool  to modify/inspect/serve PuavoOS images easyly.

## Overview
 
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
#### puavo-img-install

```
usage: puavo-img-install  IMAGE.img

       Installs IMAGE.img on your laptop.
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

#### Install the puavo-img-utils Package

```bash
$ wget https://github.com/basilstotz/puavo-image-utils/releases/download/v0.1-beta.35/puavo-image-utils_0.1-35_all.deb
$ sudo dpkg -i puavo-image-utils_0.1-35_all.deb
```
(Probably the version noted here is outdated, see https://github.com/basilstotz/puavo-image-utils/releases for the latest release)


#### Compile the Example

```bash
$ mkdir MYIMAGES && cd MYIMAGES
$ puavo-img-tool --sourceimage /images/ltsp.img --datadir /opt/puavo-img-utils/example/datadir
$ puavo-img-tool
```
This might take a while. Expect something like half an hour.

#### Test Your New Image

In order to test your new image, you can open it on a virtualized machine

```bash
$ puavo-img-live YOURNEIMAGE.img
```
or you can install it on your laptop

```bash
$ puavo-img-install YOURNEIMAGE.img
```

#### Compile Your own Image

In a first step we (only) add packages from a Debian repository and local packages. This is done by modifying the content of `datatadir/lists.d` and `datadir/debs.d`. (Leave the other dirs in `datadir`alone, unless you know what you do.)

###### Prepare Your Own Datadir 

First copy the example datadir to your imagedir

```bash
$ cd MYIMAGES
$ cp -r /opt/puavo-image-utils/example/datadir ./
```

Then have to tell `puavo-ing-tool` the location of our modified `datadir`

```bash
$ puavo-img-tool --datadir ./datadir
```
###### Add Debian Standard Packages

We want to remove the `example.list` and  install some the gnome apps

```bash
$ rm ./datadir/list.d/example.list 
$ echo "gnome-sound-recorder gnome-maps gnome-calendar gnome-todo gnome-weather geary" > ./datadir/list.d/gnome-basis.list
```
- A list is a file named `whateveryouwant.list`. 
- It contains a whitespace separated list von installable Debian packages.
- You can have any number of list files.
- All packages **must** be installable from a Debian repository.

###### Add Local Debian Packages

And now we want to install `puavo-image-utils_0.1-XXX_all.deb` in the new image

```bash
$ cp puavo-image-utils_0.1-XXX_all.deb  ./datadir/debs.d/.
```
- You can put a many debian packages as you like.
- Be shure the are actually working on a debian system.

###### Optionally Adapt Image Name

If you like, you can change the name of the image

```bash
$ puavo-img-tool --osname puavo --class extra
```

so the name of the image will be someting like `puavo-os-extra-buster-XXXX-XX-XX-XXXXX-amd64.img`.

###### Build the Image

Now, you can build your first own image with 

```bash
$ puavo-img-tool
```


#### Build a Mirror

And finally, this command take all the images in in MYIMAGES and builds a mirror, suitable to serve your images over the internet.

```bash
$ cd MYIMAGES
$ puavo-img-repo ./
```
You just can add or remove images. Run `puavo-img-repo` again, and your mirror will be updated.



## puavo-img-tool

### How it works

When the datadir contains (at least one of) folder(s) whit names **pre.d**, **bin.d**, **files.d**, **lists.d**, **debs.d**, **parts.d** they are automatacilly handeld by the builtin chroot script. 

0. Mounts SOURCE.img as a wrteable chroot
1. Copies the content of DATADIR to the chroot
2. Runs all executeables in DATADIR/**pre.d/\*.sh** , just before entering the chroot.
3. Enters chroot
4.    Runs all executeables in DATADIR/**bin.d/\*.sh**. 
5.    Installs the file tree in DATADIR/**files.d/\*** to the root directory **/**
6.    Installs (with apt) all debs, which are contained in whitespace separated list files in DATADIR/**lists.d/\*.list**
7.    Installs all local debs in DATADIR/**debs.d/\*.deb**. All dependencies are (hopefully) resolved at the end.
8.    Executes all parts (or snippets) in DATADIR/**parts.d/\PARTNAME/install.sh**.  
8. Exits chroot
9. Builds new image from the modified chroot.

#### Example Datadir

In **/opt/puavo-image-utils/example/datadir** you'll find a working example datadir. I does:

- install `gnome-maps`
- make a new category `Meine Programme` in the puavo menu, containing the newly installed `gnome-maps`. 

This is the content of `/opt/puavo-image-utils/datadir`:

```
/opt/puavo-image-utils/example/datadir/
├── bin.d
│   └── puavomenu-auto-init.sh
├── debs.d
├── files.d
├── lists.d
│   ├── example.list
├── parts.d
│   └── zzz_puavomenu-auto
│       ├── install.sh
│       └── make-menu-auto.sh
└── pre.d
    └── patch-image-conf.sh
```

#### More About Parts

Parts are mainly used to install/modify things "outside" of Debian.

- Parts are simple directories, which just **must** contain an executeable **install.sh** in (ba)sh. 
- The individual install.sh **can** either download things (during install in chroot) and/or **can** use content enbedded in the directory.

##### Example Parts
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

## Using Your Own Puavo Image Repository

#### Expose Mirror to the Internet

To serve your mirror in the internet any hosted web service with enough space (~300 GBytes) will be fine.  Just move ( with `rscnc` or friends) your mirror to the root of your web space, in order to be accessible directly at `https://your.domain.tld/` .

#### Make Clients to Your Use Your Repository

Just add the following to the clients   `puavo-conf` setup:

```json
{
  "puavo.image.servers":  "your.domain.tld"
}
```
#### Make PuavoBoxes to Cache Your Repository

###### Announce your Repository

Add the following to the PuavoBoxes `puavo-conf` setup, in order to cache your repository localy: 

```json
{
  "puavo.image.series.urls": [
       "https://your.domain.tld/meta/osname-os-oneclass-buster-amd64.json",
       "https://your.domain.tld/meta/osname-os-anotherclass-buster-amd64.json"
      ]
}
```
Your find all the correct names of the series in `MIRRORDIR/meta/*.json`.

###### Fix the Certificate Problem

PuavoBoxes need a certificate issued by Opinsys in order to download something from a image repository. As you (and me) dont have this certificate, we have to apply a patch to the image.

The patch can be easyly applied using `puavo-img-tool` and it will go `DATADIR/bin.d/`:


```bash
$ echo "sed -i /usr/sbin/puavo-bootserver-sync-images -e's/VERIFY_PEER/VERIFY_NONE/g'" > ./datadir/bin.d/bootserver-cert-patch.sh
$ chmod +x ./datadir/bin.d/bootserver-cert-patch.sh
```
**Caution: This might be security issue!**

## Usefull Links

Background knowledge about PuavoOS and PuavoOS-images:

- More information https://puavo.org and source code https://github.com/puavo-org
- An introduction to image Puavo image building and patching in general (in german): https://hackmd.io/lliTWflmTiSJ3zmLddRCaA
- Setup an Puavo image repostory (in german too):  https://hackmd.io/gdqd7gnpTSKORQEyW5y1EA
- An general introduction to the Puavo ICT environment for schools (in german): https://hackmd.io/D1U0ywlLSva94FMxy3hGSg 
- An introduction to PuavoOS, a Debian based OS for schools (in german): https://hackmd.io/519PnTRuSbaK-tCxs5eIrw
