################################################################################
#
# qoriq-pyang
#
################################################################################

QORIQ_PYANG_VERSION = pyang-2.0.1
QORIQ_PYANG_SITE = https://github.com/mbj4668/pyang.git
QORIQ_PYANG_SITE_METHOD = git
QORIQ_PYANG_INSTALL_STAGING = YES
QORIQ_PYANG_LICENSE = MIT
QORIQ_PYANG_LICENSE_FILES = COPYING
QORIQ_PYANG_SETUP_TYPE = setuptools
HOST_QORIQ_PYANG_DEPENDENCIES = host-python-lxml host-libxslt
QORIQ_PYANG_DEPENDENCIES = python-lxml python

define QORIQ_PYANG_INSTALL_STAGING_CMDS
	export PYTHONPATH=$(HOST_DIR)/usr/lib/python2.7/site-packages
	cd $(@D);$(HOST_DIR)/usr/bin/python $(@D)/setup.py install --prefix=$(HOST_DIR)/usr
endef

$(eval $(python-package))
$(eval $(host-python-package))
