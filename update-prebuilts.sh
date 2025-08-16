#!/bin/bash

if [ -z "$@" ]; then
	echo usage: bash ./update-prebuilts.sh /path/to/built/kernel/out/files
	exit 1
fi

set -v

rm -rf prebuilts
mkdir -p prebuilts/dts/vendor/qcom/
cp $@/arch/arm64/boot/* prebuilts/
cp $@/arch/arm64/boot/dts/vendor/qcom/* prebuilts/dts/vendor/qcom/
cp $@/.config arch/arm64/configs/vendor/chime_defconfig
rm -f prebuilts/Image
rm -f prebuilts/dtb
