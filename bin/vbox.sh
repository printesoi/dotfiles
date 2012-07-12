#!/bin/bash
#sudo modprobe vboxdrv vboxguest vboxsf vboxvideo
#sudo modprobe vboxsf vboxvideo
                               
for mod in vboxdrv vboxnetadp vboxnetflt vboxvideo; do
	sudo modprobe $mod;
done
