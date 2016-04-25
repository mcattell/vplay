# vplay
Experimental QML Multimedia App

Description
===========
Small QML application created as a frontend to experiment with the Qt Quick Multimedia module on the Raspberry Pi.

Instructions
============
A note of the things necessary to get it to run on a Raspberry Pi II using the eglfs qpa backend, linaro cross compile toolchain and a sysroot created from the latest raspbian. The instructions for cross compiling Qt can be found here:

https://wiki.qt.io/RaspberryPi2EGLFS

1. Cross compile Qt 5.6 from source with gstreamer enabled. The configure flag necessary for this is -gstreamer 1.0
The actual configure line (taken from config.status) of qtbase is thus:

/home/matthew/raspi/qtbase/configure -release -opengl es2 -device linux-rasp-pi2-g++ -device-option CROSS_COMPILE=/home/
matthew/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf- -sysroot /home/matt
hew/raspi/sysroot -opensource -confirm-license -make libs -prefix /usr/local/qt5pi -extprefix /home/matthew/raspi/qt5pi 
-hostprefix /home/matthew/raspi/qt5 -gstreamer 1.0

2. It's necessary to use gstreamer 1.0 because much of the functionality for playing video is enabled in the later version of gstreamer and Qt Multimedia. I wasn't able to play video with gstreamer 0.1 as not all the necessary codecs could be loaded at run time. This problem(s) seem to have been resolved in gstreamer 1.0

Notes
=====
The application doesn't yet include a pick list of videos. Instead, the path to an avi is hard coded for testing. In future the intention is to add a scrollable list of media files and perhaps make it work with VLC streaming server or something similar.
