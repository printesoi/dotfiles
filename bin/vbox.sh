#!/bin/bash
#sudo modprobe vboxdrv vboxguest vboxsf vboxvideo
#sudo modprobe vboxsf vboxvideo

for mod in vboxdrv vboxpci vboxnetadp vboxnetflt; do
    sudo modprobe $mod;
done
