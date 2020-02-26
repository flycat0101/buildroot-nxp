################################################################################
#
# qoriq-netopeer2-server
#
################################################################################

QORIQ_NETOPEER2_SERVER_VERSION = 0.7-r2
QORIQ_NETOPEER2_SERVER_SITE = $(call github,CESNET,Netopeer2,v$(QORIQ_NETOPEER2_SERVER_VERSION))
QORIQ_NETOPEER2_SERVER_SUBDIR = server
QORIQ_NETOPEER2_SERVER_INSTALL_STAGING = NO
QORIQ_NETOPEER2_SERVER_LICENSE = BSD-3c
QORIQ_NETOPEER2_SERVER_LICENSE_FILES = LICENSE
QORIQ_NETOPEER2_SERVER_DEPENDENCIES = libnetconf2 netopeer2-keystored

define QORIQ_NETOPEER2_SERVER_INSTALL_DAEMON_SCRIPT
	$(INSTALL) -D -m 0751 package/netopeer2-server/S91netopeer2-server \
		$(TARGET_DIR)/etc/init.d/
endef

QORIQ_NETOPEER2_SERVER_POST_INSTALL_TARGET_HOOKS = QORIQ_NETOPEER2_SERVER_INSTALL_DAEMON_SCRIPT

# prevent an attempted chown to root:root
QORIQ_NETOPEER2_SERVER_CONF_OPTS += -DSYSREPOCTL_ROOT_PERMS="-p 666"
QORIQ_NETOPEER2_SERVER_MAKE_ENV = LD_LIBRARY_PATH+=$(HOST_DIR)/usr/lib:$(HOST_DIR)/lib
# the .pc file is for the target, and therefore not consulted during the build
QORIQ_NETOPEER2_SERVER_CONF_OPTS += -DKEYSTORED_KEYS_DIR=/etc/keystored/keys

$(eval $(cmake-package))
