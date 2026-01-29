#!/usr/bin/env bash

#  _   _      _   _   _             _            
# | \ | | ___| |_| | | |_   _ _ __ | |_ ___ _ __ 
# |  \| |/ _ \ __| |_| | | | | '_ \| __/ _ \ '__|
# | |\  |  __/ |_|  _  | |_| | | | | ||  __/ |   
# |_| \_|\___|\__|_| |_|\__,_|_| |_|\__\___|_|

NETHUNTER_PROJECT="kali-nethunter-project"
O="out"
ARCH="arm64"

DEVICE="umi"
ANDROID_VERSION="thirteen" # kali nethunter only support android 13 and below
UMI="$(pwd)/$NETHUNTER_PROJECT/nethunter-installer/devices/$ANDROID_VERSION/$DEVICE"

mkdir -p ${UMI}/modules/system/lib/modules

echo "[!] clean old files"
rm -rf ${UMI}/Image
rm -rf ${UMI}/Image-dtb
rm -rf ${UMI}/Image-dtb-hdr
rm -rf ${UMI}/dtbo.img
rm -rf ${UMI}/dtb
rm -rf ${UMI}/modules/system/lib/modules/*

echo "[+] add kernel image"
cp ${O}/arch/${ARCH}/boot/Image ${UMI}/Image
cp ${O}/arch/${ARCH}/boot/Image-dtb ${UMI}/Image-dtb
cp ${O}/arch/${ARCH}/boot/Image-dtb-hdr ${UMI}/Image-dtb-hdr

cp -r $(pwd)/$O/lib/modules/* ${UMI}/modules/system/lib/modules/

cd $(pwd)/${NETHUNTER_PROJECT}/nethunter-installer/
python3 build.py -d umi --thirteen --kernel
