################################################################################
#
# qoriq-mc-utils
#
################################################################################

QORIQ_MC_UTILS_VERSION = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_UTILS_VERSION))
QORIQ_MC_UTILS_SITE = https://source.codeaurora.org/external/qoriq/qoriq-components/mc-utils
QORIQ_MC_UTILS_SITE_METHOD = git
QORIQ_MC_UTILS_LICENSE = GPL2.0

UBOOT_BOARDNAME = $(call qstrip,$(BR2_TARGET_UBOOT_BOARDNAME))
BOARD_NAME = $(firstword $(subst _, ,$(UBOOT_BOARDNAME)))

ifeq ($(BOARD_NAME), lx2160ardb)
MC_UTILS_BOARDPATH = lx2160a/RDB
FPL_FILE = dpl-eth.19.dtb
DPC_FILE = dpc-usxgmii.dtb
endif

define QORIQ_MC_UTILS_BUILD_CMDS
	make -C $(@D)/config/
	cp $(@D)/config/${MC_UTILS_BOARDPATH}/${DPC_FILE} $(BINARIES_DIR)/
	cp $(@D)/config/${MC_UTILS_BOARDPATH}/${FPL_FILE} $(BINARIES_DIR)/
endef

$(eval $(generic-package))
