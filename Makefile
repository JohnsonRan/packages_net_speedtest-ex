include $(TOPDIR)/rules.mk

PKG_NAME:=speedtest-ex
PKG_VERSION:=1.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/WJQSERVER/speedtest-ex/tar.gz/$(PKG_VERSION)?
PKG_HASH:=7f70655bdeb1c352178d4c4794f1af2546f16220ab1632cf6d347505828afd47

PKG_MAINTAINER:=JohnsonRan <me@ihtw.moe>
PKG_LICENSE:=LGPL-3.0

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
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
  URL:=https://github.com/WJQSERVER/speedtest-ex
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/speedtest-ex/description
  This project is a significant refactor of the speedtest-go project
endef

define Package/speedtest-ex/conffiles
/etc/speedtest-ex
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

define Build/Prepare
	$(Build/Prepare/Default)
	$(RM) -r $(PKG_BUILD_DIR)/rules/logic_test
endef

$(eval $(call GoBinPackage,speedtest-ex))
$(eval $(call BuildPackage,speedtest-ex))
