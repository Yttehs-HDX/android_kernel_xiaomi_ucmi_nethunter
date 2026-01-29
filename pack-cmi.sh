#!/usr/bin/env bash

#  _   _      _   _   _             _            
# | \ | | ___| |_| | | |_   _ _ __ | |_ ___ _ __ 
# |  \| |/ _ \ __| |_| | | | | '_ \| __/ _ \ '__|
# | |\  |  __/ |_|  _  | |_| | | | | ||  __/ |   
# |_| \_|\___|\__|_| |_|\__,_|_| |_|\__\___|_|

NETHUNTER_PROJECT="kali-nethunter-project"
O="out"
ARCH="arm64"

DEVICE="cmi"
ANDROID_VERSION="thirteen" # kali nethunter only support android 13 and below
CMI="$(pwd)/$NETHUNTER_PROJECT/nethunter-installer/devices/$ANDROID_VERSION/$DEVICE"

mkdir -p ${CMI}/modules/system/lib/modules

echo "[!] clean old files"
rm -rf ${CMI}/Image
rm -rf ${CMI}/Image-dtb
rm -rf ${CMI}/Image-dtb-hdr
rm -rf ${CMI}/dtbo.img
rm -rf ${CMI}/dtb
rm -rf ${CMI}/modules/system/lib/modules/*

echo "[+] add kernel image"
cp ${O}/arch/${ARCH}/boot/Image ${CMI}/Image
cp ${O}/arch/${ARCH}/boot/Image-dtb ${CMI}/Image-dtb
cp ${O}/arch/${ARCH}/boot/Image-dtb-hdr ${CMI}/Image-dtb-hdr

cp -r $(pwd)/$O/lib/modules/* ${CMI}/modules/system/lib/modules/

cd $(pwd)/${NETHUNTER_PROJECT}/nethunter-installer/
python3 build.py -d cmi --thirteen --kernel
