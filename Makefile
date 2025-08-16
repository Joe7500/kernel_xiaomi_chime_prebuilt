# Fake kernel Makefile for prebuilts.

DEFCONFIG := arch/arm64/configs/vendor/chime_defconfig
KERNELRELEASE := $(shell python get_kernel_version.py prebuilts/Image.gz)

define copy-out-files
	@mkdir -p $(O)/
	@cp -f $(DEFCONFIG) $(O)/.config
	@mkdir -p $(O)/include/config/
	@echo $(KERNELRELEASE) > $(O)/include/config/kernel.release
	@mkdir -p $(O)/arch/arm64/boot
	@cp -a prebuilts/* $(O)/arch/arm64/boot/
	@touch $(O)/arch/arm64/boot/dts/vendor/qcom/modules.order
	@find $(O)/ -type f -exec touch {} +
endef

.PHONY: all
all: Image.gz dtbs vendor/chime_defconfig headers_install

.PHONY: vendor/chime_defconfig
vendor/chime_defconfig:
	@mkdir -p $(O)/
	@cp -f $(DEFCONFIG) $(O)/.config
	@echo "[PREBUILT KERNEL chime_defconfig] $(O)"

.PHONY: Image.gz
Image.gz:
	$(copy-out-files)
	@echo "[PREBUILT KERNEL Image.gz] $(O)"

.PHONY: dtbs
dtbs:
	$(copy-out-files)
	@echo "[PREBUILT KERNEL dtbs] $(O)"

.PHONY: headers_install
headers_install:
	@mkdir -p $(O)/usr
	@cp -a $(shell pwd)/kernel_headers/* $(O)/usr/
	@find $(O)/ -type f -exec touch {} +
	@echo "[PREBUILT KERNEL headers_install] $(O)/usr/"

modules:
	@true

modules_install:
	@true

