################################################################################
#
# qoriq-mc-fw
#
################################################################################

QORIQ_MC_FW_VERSION = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_FW_VERSION))
QORIQ_MC_FW_SITE = https://github.com/NXP/qoriq-mc-binary.git
QORIQ_MC_FW_SITE_METHOD = git
QORIQ_MC_FW_LICENSE = GPL2.0

UBOOT_BOARDNAME = $(call qstrip,$(BR2_TARGET_UBOOT_BOARDNAME))
BOARD_NAME = $(firstword $(subst _, ,$(UBOOT_BOARDNAME)))

ifeq ($(findstring lx2160a, $(BOARD_NAME)), lx2160a)
BOARD_PATH=lx2160a
BIN_FILE=mc_10.18.0_lx2160a.itb
endif

MC_FW_FILE = mc.itb

define QORIQ_MC_FW_BUILD_CMDS
	cp $(@D)/${BOARD_PATH}/${BIN_FILE} $(BINARIES_DIR)/${MC_FW_FILE}
endef

$(eval $(generic-package))
