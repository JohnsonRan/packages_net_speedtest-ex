include $(TOPDIR)/rules.mk

PKG_NAME:=speedtest-ex
PKG_VERSION:=0.0.9
PKG_RELEASE:=6

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/WJQSERVER/speedtest-ex/tar.gz/$(PKG_VERSION)?
PKG_HASH:=c5e050b9c687cc94c4e9f962a6c9cd6d57772d3debd79e736125b4db330befc9

PKG_MAINTAINER:=JohnsonRan <me@ihtw.moe>
PKG_LICENSE:=LGPL-3.0
PKG_LICENSE_FILE:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=speedtest
GO_PKG_BUILD_PKG:=$(GO_PKG)
CGO_ENABLED:=0
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:=main.version=v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/speedtest-ex
  SECTION:=net
  CATEGORY:=Network
  TITLE:=This project is a significant refactor of the speedtest-go project
  DEPENDS:=$(GO_ARCH_DEPENDS)
  MAINTAINER:=$(PKG_MAINTAINER)
endef

define Package/speedtest-ex/description
  This project is a significant refactor of the speedtest-go project
endef

define Package/speedtest-ex/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/speedtest $(1)/usr/bin/speedtest-ex
	
	$(INSTALL_DIR) $(1)/etc/speedtest-ex
	$(INSTALL_CONF) $(CURDIR)/files/config.toml $(1)/etc/speedtest-ex
	
	$(INSTALL_DIR) $(1)/etc/speedtest-ex/db
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(CURDIR)/files/speedtest-ex.init $(1)/etc/init.d/speedtest-ex
endef

define Package/mihomo/postrm
#!/bin/sh
if [ -z $${IPKG_INSTROOT} ]; then
	service speedtest-ex stop > /dev/null 2>&1
	rm /etc/init.d/speedtest-ex > /dev/null 2>&1
	EOF
fi
endef

$(eval $(call GoBinPackage,speedtest-ex))
$(eval $(call BuildPackage,speedtest-ex))