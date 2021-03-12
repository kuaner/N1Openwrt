#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon

# Mod zzz-default-settings
sed -i "/commit luci/i\uci set luci.main.mediaurlbase='/luci-static/argon'" package/lean/default-settings/files/zzz-default-settings

# Change default package
sed -i 's/automount autosamba luci-app-adbyby-plus luci-app-ipsec-vpnd luci-app-unblockmusic luci-app-cpufreq luci-app-zerotier //g' target/linux/ipq40xx/Makefile
sed -i 's/luci-app-vsftpd //g' include/target.mk
sed -i 's/luci-app-unblockmusic //g' include/target.mk
sed -i 's/luci-app-nlbwmon luci-app-accesscontrol //g' include/target.mk
sed -i 's/luci-app-ddns luci-app-upnp luci-app-autoreboot luci-app-webadmin //g' include/target.mk
sed -i 's/luci-app-wol //g' include/target.mk
