#!/bin/bash

UBOOT_BUILD_DIR=u-boot-2016.03-zynq-zybo-z7

### Download U-Boot Source
git clone git://git.denx.de/u-boot.git $UBOOT_BUILD_DIR
cd $UBOOT_BUILD_DIR

#### Checkout v2016.03
git checkout -b v2016.03-zynq-zybo-z7 refs/tags/v2016.03

### Patch for zynq-zybo-z7

patch -p0 < ../files/u-boot-2016.03-zynq-zybo-z7.diff
git add --update
git add arch/arm/dts/zynq-zybo-z7.dts
git add board/xilinx/zynq/zybo_z7_hw_platform/*
git add configs/zynq_zybo_z7_defconfig
git add include/configs/zynq_zybo_z7.h
git commit -m "patch for zynq-zybo-z7"
git tag -a "v2016.03-zynq-zybo-z7-1" -m "Release v2016.03-1 for zynq-zybo-z7"

### Setup for Build 

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make zynq_zybo_z7_defconfig

### Build u-boot

make

### Copy boot.bin and u-boot.img to root directory

cp spl/boot.bin  ../boot.bin
cp u-boot.img    ../u-boot.img
cp u-boot        ../u-boot.elf

cd ..
