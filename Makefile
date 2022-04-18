#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/package.mk

PKG_NAME:=luci-app-frpc
PKG_VERSION:=1
PKG_RELEASE:=8
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

PO2LMO:=$(TOPDIR)/po2lmo

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  DEPENDS:=+wget
  TITLE:=luci-app-frpc
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
 luci-app-frpc mod by haxc
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh 
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-frp ) && rm -f /etc/uci-defaults/luci-frp
	/etc/init.d/frp enable >/dev/null 2>&1
	exit 0
}
endef

define Package/$(PKG_NAME)/install
	$(CP) ./root/* $(1)
	#$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(PO2LMO) ./po/zh-cn/frp.zh-cn.po $(1)/usr/lib/lua/luci/i18n/frp.zh-cn.lmo
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
endef

$(eval $(call BuildPackage,$(PKG_NAME)))