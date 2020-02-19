################################################################################
#
# qoriq-optee-client
#
################################################################################

QORIQ_OPTEE_CLIENT_VERSION = 2.4.0
QORIQ_OPTEE_CLIENT_SITE = https://github.com/OP-TEE/optee_client.git
QORIQ_OPTEE_CLIENT_SITE_METHOD = git
QORIQ_OPTEE_CLIENT_LICENSE =  BSD 2-Clause
QORIQ_OPTEE_CLIENT_LICENSE_FILES = LICENSE

define QORIQ_OPTEE_CLIENT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define QORIQ_OPTEE_CLIENT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
