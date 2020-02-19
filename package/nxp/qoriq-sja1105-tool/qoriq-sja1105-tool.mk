################################################################################
#
# qoriq-sja1105-tool
#
################################################################################

QORIQ_SJA1105_TOOL_VERSION = master
QORIQ_SJA1105_TOOL_SITE = https://github.com/openil/sja1105-tool.git
QORIQ_SJA1105_TOOL_SITE_METHOD = git
QORIQ_SJA1105_TOOL_INSTALL_STAGING = YES
QORIQ_SJA1105_TOOL_LICENSE = BSD-3c
QORIQ_SJA1105_TOOL_LICENSE_FILES = COPYING
QORIQ_SJA1105_TOOL_DEPENDENCIES = libxml2 iomem

# By first "uninstalling" sja1105-tool and libsja1105.so from the
# build system's sysroot we make sure that sja1105-tool will correctly
# link with the fresh libsja1105.so found with -L. instead of the
# old libsja1105.so present in the sysroot. If the latter is present,
# it has higher priority for the linker and will cause issues
# if linked against.
define QORIQ_SJA1105_TOOL_BUILD_CMDS
	DESTDIR=$(STAGING_DIR) $(MAKE) -C $(@D) uninstall; \
	echo '$(QORIQ_SJA1105_TOOL_VERSION)' > $(@D)/VERSION; \
	$(TARGET_CONFIGURE_ARGS) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) $(TARGET_MAKE_OPTS);
endef

# Install headers and libsja1105.so to $(STAGING_DIR) (the sysroot)
# to make its API usable from other packages (ptp4l)
define QORIQ_SJA1105_TOOL_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install-binaries install-configs;
	DESTDIR=$(STAGING_DIR) $(MAKE) -C $(@D) install-binaries install-headers;
endef

$(eval $(generic-package))
