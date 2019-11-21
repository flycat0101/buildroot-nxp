################################################################################
#
# qoriq-cadence-dp-firmware
#
################################################################################

QORIQ_CADENCE_DP_FIRMWARE_VERSION = lsdk1909
QORIQ_CADENCE_DP_FIRMWARE_SITE = http://www.nxp.com/lgfiles/sdk/$(QORIQ_CADENCE_DP_FIRMWARE_VERSION)
QORIQ_CADENCE_DP_FIRMWARE_SOURCE = firmware-cadence-$(QORIQ_CADENCE_DP_FIRMWARE_VERSION).bin
QORIQ_CADENCE_DP_FIRMWARE_LICENSE = NXP-Binary-EULA
QORIQ_CADENCE_DP_FIRMWARE_LICENSE_FILES = COPYING
QORIQ_CADENCE_DP_FIRMWARE_INSTALL_IMAGES = YES
QORIQ_CADENCE_DP_FIRMWARE_INSTALL_TARGET = NO

define QORIQ_CADENCE_DP_FIRMWARE_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(QORIQ_CADENCE_DP_FIRMWARE_DL_DIR)/$(QORIQ_CADENCE_DP_FIRMWARE_SOURCE))
endef

define QORIQ_CADENCE_DP_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/dp/ls1028a-dp-fw.bin $(BINARIES_DIR)/ls1028a-dp-fw.bin
endef

$(eval $(generic-package))
