#!/bin/bash

# Example script to setup device tree for prebuilt kernel.
# Usage:
# cd device/xiaomi/chime
# bash ../../../kernel/xiaomi/chime/setup-devicetree.sh

RM_FLAGS="BOARD_KERNEL_IMAGE_NAME TARGET_KERNEL_HEADERS TARGET_KERNEL_SOURCE TARGET_FORCE_PREBUILT_KERNEL"
RM_FLAGS="$RM_FLAGS TARGET_PREBUILT_KERNEL TARGET_PREBUILT_DTB BOARD_PREBUILT_DTBOIMAGE TARGET_KERNEL_CONFIG"
RM_FLAGS="$RM_FLAGS TARGET_KERNEL_DIR"

for RM_FLAG in $RM_FLAGS ; do
	grep -n $RM_FLAG *  2>&1 | grep -vi 'Is a directory'
	cat BoardConfig.mk | grep -v $RM_FLAG > BoardConfig.mk.1
	mv BoardConfig.mk.1 BoardConfig.mk
    cat device.mk | grep -v $RM_FLAG > device.mk.1
	mv device.mk.1 device.mk
done

echo '' >> BoardConfig.mk

echo 'TARGET_KERNEL_DIR := kernel/xiaomi/chime' >> BoardConfig.mk

echo 'TARGET_KERNEL_HEADERS := $(TARGET_KERNEL_DIR)/kernel_headers' >> BoardConfig.mk
echo 'TARGET_KERNEL_SOURCE := $(TARGET_KERNEL_DIR)' >> BoardConfig.mk
echo 'TARGET_KERNEL_CONFIG := vendor/chime_defconfig' >> BoardConfig.mk

echo 'TARGET_FORCE_PREBUILT_KERNEL := true' >> BoardConfig.mk
echo 'TARGET_PREBUILT_KERNEL := $(TARGET_KERNEL_DIR)/prebuilts/Image.gz' >> BoardConfig.mk
echo 'TARGET_PREBUILT_DTB := $(TARGET_KERNEL_DIR)/prebuilts/dtb.img' >> BoardConfig.mk
echo 'BOARD_PREBUILT_DTBOIMAGE := $(TARGET_KERNEL_DIR)/prebuilts/dtbo.img' >> BoardConfig.mk
echo 'PRODUCT_COPY_FILES += $(TARGET_KERNEL_DIR)/prebuilts/Image.gz:kernel' >> BoardConfig.mk
echo 'PRODUCT_COPY_FILES += $(TARGET_KERNEL_DIR)/prebuilts/dtb.img:dtb.img' >> BoardConfig.mk
echo 'PRODUCT_COPY_FILES += $(TARGET_KERNEL_DIR)/prebuilts/dtbo.img:dtbo.img' >> BoardConfig.mk
echo 'BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)' >> BoardConfig.mk

