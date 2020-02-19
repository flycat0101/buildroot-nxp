################################################################################
#
# qoriq-optee-os
#
################################################################################

QORIQ_OPTEE_OS_VERSION = 2.4.0
QORIQ_OPTEE_OS_SITE = https://github.com/OP-TEE/optee_os.git
QORIQ_OPTEE_OS_SITE_METHOD = git
QORIQ_OPTEE_OS_LICENSE = BSD 2-Clause
QORIQ_OPTEE_OS_LICENSE_FILES = LICENSE
#OPTEE_OS_INSTALL_TARGET = NO
QORIQ_OPTEE_OS_DEPENDENCIES = host-python-pycrypto host-python-wand

QORIQ_OPTEE_OS_MAKE_OPTS = \
	CC="$(TARGET_CC) --sysroot=$(STAGING_DIR)/usr" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	PLATFORM="ls" \
	PLATFORM_FLAVOR="ls1021atwr"

define QORIQ_OPTEE_OS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(QORIQ_OPTEE_OS_MAKE_OPTS) -C $(@D)
	$(TARGET_MAKE_ENV) $(TARGET_OBJCOPY) -O binary $(@D)/out/arm-plat-ls/core/tee.elf $(BINARIES_DIR)/tee.bin
endef

$(eval $(generic-package))
