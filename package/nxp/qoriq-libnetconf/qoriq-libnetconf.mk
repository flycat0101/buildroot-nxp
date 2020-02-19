################################################################################
#
# qoriq-libnetconf
#
################################################################################

QORIQ_LIBNETCONF_VERSION = master
QORIQ_LIBNETCONF_SITE = https://github.com/CESNET/libnetconf.git
QORIQ_LIBNETCONF_SITE_METHOD = git
QORIQ_LIBNETCONF_INSTALL_STAGING = YES
QORIQ_LIBNETCONF_LICENSE = MIT
QORIQ_LIBNETCONF_LICENSE_FILES = COPYING
QORIQ_LIBNETCONF_CONF_OPTS += --with-rpm
HOST_QORIQ_LIBNETCONF_DEPENDENCIES = host-pkgconf host-pyang host-xsltproc
QORIQ_LIBNETCONF_DEPENDENCIES  = openssl libgcrypt libssh libxslt ncurses readline
QORIQ_LIBNETCONF_DEPENDENCIES += dbus host-pyang host-h-python-libxml2 libcurl
QORIQ_LIBNETCONF_CONF_ENV += PKG_CONFIG=$(HOST_DIR)/usr/bin/pkg-config
QORIQ_LIBNETCONF_CONF_ENV += enable_validation=no
QORIQ_LIBNETCONF_AUTORECONF := YES

define QORIQ_LIBNETCONF_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dev-tools/lnctool/lnctool $(HOST_DIR)/usr/bin
	sed -i '1c\#!$(HOST_DIR)/usr/bin/python'  $(HOST_DIR)/usr/bin/lnctool
	$(INSTALL) -D -m 0755 $(@D)/.libs/libnetconf.so* $(STAGING_DIR)/usr/lib/
	$(INSTALL) -D -m 0755 $(@D)/headers/*.h $(STAGING_DIR)/usr/include
	mkdir -p $(STA<F2>0i22i9<F2><F10>18abbznGING_DIR)/usr/include/libnetconf
	$(INSTALL) -D -m 0755 $(@D)/src/*.h $(STAGING_DIR)/usr/include/libnetconf/
	$(INSTALL) -D -m 0755 $(@D)/src/datastore/custom/datastore_custom.h $(STAGING_DIR)/usr/include/libnetconf/
	$(INSTALL) -D -m 0755 $(@D)/libnetconf.pc $(STAGING_DIR)/usr/lib/pkgconfig/
endef

$(eval $(autotools-package))
