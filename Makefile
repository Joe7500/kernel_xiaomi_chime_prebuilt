# Fake kernel Makefile for prebuilts.

DEFCONFIG := arch/arm64/configs/vendor/chime_defconfig
KERNELRELEASE := $(shell python3 get_kernel_version.py prebuilts/Image.gz)

define output-files
	@mkdir -p $(O)/
	@cp -f $(DEFCONFIG) $(O)/.config
	@mkdir -p $(O)/include/config/
	@echo $(KERNELRELEASE) > $(O)/include/config/kernel.release
	@mkdir -p $(O)/arch/arm64/boot
	@cp -a prebuilts/* $(O)/arch/arm64/boot/
	@touch $(O)/arch/arm64/boot/dts/vendor/qcom/modules.order
	@mkdir -p $(O)/usr
	@cp -a kernel_headers/* $(O)/usr/
	@find $(O)/ -type f -exec touch {} +
endef

# Output all prebuilt files regardless of make target.
# With the right files, this is enough to fake a full kernel source build.

.DEFAULT:
	$(output-files)
	@echo "[PREBUILT KERNEL] $(O)"

all: .DEFAULT
