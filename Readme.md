FPGA-SoC-U-Boot-ZYBO-Z7
====================================================================================

Overview
------------------------------------------------------------------------------------

### Introduction

This Repository provides a U-Boot Image for ZYBO-Z7.

### Features

* U-Boot v2017.11 (customized)
  + Build for ZYBO-Z7
  + Customized boot by uEnv.txt
  + Customized boot by boot.scr
  + Enable bootmenu

Build U-boot for ZYBO-Z7
------------------------------------------------------------------------------------

There are two ways

1. run scripts/build-u-boot-2017.11-zynq-zybo-z7.sh (easy)
2. run this chapter step-by-step (annoying)

### Download U-boot Source

#### Clone from git.denx.de/u-boot.git

```console
shell$ git clone git://git.denx.de/u-boot.git u-boot-2017.11-zynq-zybo-z7
```

#### Checkout v2017.11

```console
shell$ cd u-boot-2017.11-zynq-zybo-z7
shell$ git checkout -b u-boot-2017.11-zynq-zybo-z7 refs/tags/v2017.11
```

### Patch for zynq-zybo-z7

```console
shell$ patch -p1 < ../files/u-boot-2017.11-zynq-preboot.diff
shell$ git add --update
shell$ git commit -m "[update] for zynq to import uEnv.txt at PREBOOT and to use bootmenu"
```

```console
shell$ patch -p1 < ../files/u-boot-2017.11-zynq-spi-mac-addr.diff
shell$ git add --update
shell$ git commit -m "[update] for zynq to read mac address from spi"
```

```console
shell$ patch -p1 < ../files/u-boot-2017.11-zynq-zybo-z7.diff
shell$ git add --update
shell$ git add arch/arm/dts/zynq-zybo-z7.dts
shell$ git add board/xilinx/zynq/zynq-zybo-z7/*
shell$ git add configs/zynq_zybo_z7_defconfig
shell$ git add include/configs/zynq_zybo_z7.h
shell$ git commit -m "[patch] for zynq-zybo-z7"
```

```console
shell$ git tag -a v2017.11-zynq-zybo-z7-1 -m "Release v2017.11-1 for zynq-zybo-z7"
```

### Setup for Build 

```console
shell$ cd u-boot-2017.11-zynq-zybo-z7
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ make zynq_zybo_z7_defconfig
```

### Build u-boot

```console
shell$ make
```

### Copy u-boot.img, u-boot.elf and u-boot-spl.sfp to root directory

```console
shell$ cp spl/boot.bin  ../boot.bin
shell$ cp u-boot.img    ../u-boot.img
shell$ cp u-boot        ../u-boot.elf
```
