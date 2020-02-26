################################################################################
#
# qoriq-netopeer2-keystored
#
################################################################################

QORIQ_NETOPEER2_KEYSTORED_VERSION = 0.7-r2
QORIQ_NETOPEER2_KEYSTORED_SITE = $(call github,CESNET,Netopeer2,v$(QORIQ_NETOPEER2_KEYSTORED_VERSION))
QORIQ_NETOPEER2_KEYSTORED_SUBDIR = keystored
QORIQ_NETOPEER2_KEYSTORED_INSTALL_STAGING = NO
QORIQ_NETOPEER2_KEYSTORED_LICENSE = BSD-3c
QORIQ_NETOPEER2_KEYSTORED_LICENSE_FILES = LICENSE
QORIQ_NETOPEER2_KEYSTORED_DEPENDENCIES = openssl sysrepo
QORIQ_NETOPEER2_KEYSTORED_MAKE_ENV += LD_LIBRARY_PATH+=$(HOST_DIR)/usr/lib:$(HOST_DIR)/lib

# prevent an attempted chown to root:root
QORIQ_NETOPEER2_KEYSTORED_CONF_OPTS += -DSYSREPOCTL_ROOT_PERMS="-p 666"
# we are responsible for providing a PEM file at /etc/keystored/keys/ssh_host_rsa_key.pem
QORIQ_NETOPEER2_KEYSTORED_CONF_OPTS += -DKEYSTORED_DEFER_SSH_KEY=ON

define QORIQ_NETOPEER2_KEYSTORED_INSTALL_DAEMON_SCRIPT
	$(INSTALL) -D -m 0751 package/netopeer2-keystored/S80netopeer2-keystored \
		$(TARGET_DIR)/etc/init.d/
endef

QORIQ_NETOPEER2_KEYSTORED_POST_INSTALL_TARGET_HOOKS = QORIQ_NETOPEER2_KEYSTORED_INSTALL_DAEMON_SCRIPT

$(eval $(cmake-package))
