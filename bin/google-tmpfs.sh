#!/bin/bash

mkdir /media/chrome-ramdisk/google-chrome
rm -rf ~/.cache/google
ln -s  /media/chrome-ramdisk/google-chrome ~/.cache/google-chrome
