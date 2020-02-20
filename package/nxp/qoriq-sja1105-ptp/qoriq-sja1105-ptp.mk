################################################################################
#
# qoriq-sja1105-ptp
#
################################################################################

QORIQ_SJA1105_PTP_VERSION = OpenIL-linuxptp-201712
QORIQ_SJA1105_PTP_SITE = https://github.com/openil/linuxptp.git
QORIQ_SJA1105_PTP_SITE_METHOD = git
QORIQ_SJA1105_PTP_LICENSE = GPL2
QORIQ_SJA1105_PTP_LICENSE_FILES = COPYING
ifeq ($(BR2_PACKAGE_QORIQ_SJA1105_TOOL),y)
QORIQ_SJA1105_PTP_DEPENDENCIES = sja1105-tool
QORIQ_SJA1105_OUTPUT=$(STAGING_DIR)/usr
endif

QORIQ_SJA1105_PTP_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	SJA1105_ROOTDIR="$(SJA1105_OUTPUT)" \
	SJA1105_PTP_TC=y \

define QORIQ_SJA1105_PTP_BUILD_CMDS
	export PKG_CONFIG_SYSROOT_DIR="$(STAGING_DIR)"; \
	export KBUILD_OUTPUT="$(STAGING_DIR)"; \
	$(TARGET_MAKE_ENV) $(MAKE1) $(QORIQ_SJA1105_PTP_MAKE_OPTS) -C $(@D)
endef

define QORIQ_SJA1105_PTP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/sja1105-ptp $(TARGET_DIR)/usr/sbin/sja1105-ptp
	cp -dpfr $(@D)/sja1105-ptp-tc.sh $(TARGET_DIR)/usr/sbin/sja1105-ptp-tc.sh
endef

$(eval $(generic-package))
