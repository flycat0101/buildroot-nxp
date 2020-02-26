################################################################################
#
# qoriq-yang-sja1105
#
################################################################################

QORIQ_YANG_SJA1105_VERSION = 0.3-rc1
QORIQ_YANG_SJA1105_SITE = package/yang-sja1105/sja1105
QORIQ_YANG_SJA1105_SITE_METHOD = local
QORIQ_YANG_SJA1105_LICENSE = MIT
QORIQ_YANG_SJA1105_LICENSE_FILES = COPYING
QORIQ_YANG_SJA1105_DEPENDENCIES = libxml2 pyang libnetconf sja1105-tool
QORIQ_YANG_SJA1105_CONF_ENV += PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig"
QORIQ_YANG_SJA1105_CONF_ENV += PYTHON_CONFIG="$(STAGING_DIR)/usr/bin/python-config"
QORIQ_YANG_SJA1105_CONF_ENV += ac_cv_path_NETOPEER_MANAGER="$(HOST_DIR)/usr/bin/netopeer-manager.host"
QORIQ_YANG_SJA1105_CONF_ENV += CFLAGS+="-Wextra -Wall -Wunused-function -Wunused-label -Werror"

define QORIQ_YANG_SJA1105_CREATE_CONFIGURE
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/lnctool --model ./sja1105.yang \
	                                      transapi --paths ./paths.txt; \
	$(INSTALL) -D -m 0755 $(TOPDIR)/package/yang-sja1105/sja1105/sja1105.c \
	                    $(BUILD_DIR)/yang-sja1105-$(QORIQ_YANG_SJA1105_VERSION)/;\
	cd $(TOPDIR); \
	$(APPLY_PATCHES) $(@D) package/yang-sja1105/ \
	         0001-yang-sja1105-modify-configure-file-pass-buildroot.patch; \
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/autoreconf --force --install
endef

define QORIQ_YANG_SJA1105_CONFIGURE_CMDS
	cd $(@D); \
	$(TARGET_CONFIGURE_ARGS) $(TARGET_CONFIGURE_OPTS) $(QORIQ_YANG_SJA1105_CONF_ENV) \
	    ./configure  --prefix=/usr/local/ \
	    --host=arm-buildroot-linux-gnueabihf \
	    --build=x86_64-pc-linux-gnu \
	    --with-libxml2=$(STAGING_DIR)/usr/bin
endef

define QORIQ_YANG_SJA1105_LNCTOOL_CREATE_FILES
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/lnctool --model \
	    `pwd`/sja1105.yang --search-path `pwd` --output-dir `pwd` validation;
endef

define QORIQ_YANG_SJA1105_COPY_SJA1105_TOOL_CONF
	install -Dm0644 $(TOPDIR)/package/yang-sja1105/sja1105/sja1105-tool.conf \
		$(TARGET_DIR)/usr/local/etc/netopeer/sja1105/sja1105-tool.conf
endef

QORIQ_YANG_SJA1105_PRE_CONFIGURE_HOOKS += QORIQ_YANG_SJA1105_CREATE_CONFIGURE
QORIQ_YANG_SJA1105_POST_BUILD_HOOKS += QORIQ_YANG_SJA1105_LNCTOOL_CREATE_FILES
QORIQ_YANG_SJA1105_POST_INSTALL_TARGET_HOOKS += QORIQ_YANG_SJA1105_COPY_SJA1105_TOOL_CONF

$(eval $(autotools-package))
