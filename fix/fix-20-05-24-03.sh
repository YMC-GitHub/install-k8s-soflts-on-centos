#!/bin/sh

# fix:虚拟机 Centos7网络配置 ping：www.baidu.com:未知的名称或服务 ping不通

NEW_NET_CARD_NAME=eth1
USE_ON_BOOT=yes
NET_CARD_MAC="08:00:27:f6:1f:31"
VM_IPADDR=192.168.56.2
VM_NETMASK=255.255.255.0
VM_GATEWAY=192.168.56.1
BOOT_PROTO="static"

FILE="/etc/sysconfig/network-scripts/ifcfg-${NEW_NET_CARD_NAME}"
sed -i "s/^DNS1=.*//g"  "$FILE"
sed -i "/^$/d"  "$FILE"
echo "DNS1=\"$VM_GATEWAY\"" >> "$FILE"
cat "$FILE"

NEW_NET_CARD_NAME=eth2
USE_ON_BOOT=yes
NET_CARD_MAC="08:00:27:f6:1f:32"
VM_IPADDR=10.0.1.2
VM_NETMASK=255.255.255.0
VM_GATEWAY=10.0.1.1
BOOT_PROTO="static"

FILE="/etc/sysconfig/network-scripts/ifcfg-${NEW_NET_CARD_NAME}"
sed -i "s/^DNS1=.*//g"  "$FILE"
sed -i "/^$/d"  "$FILE"
echo "DNS1=\"$VM_GATEWAY\"" >> "$FILE"
cat "$FILE"
service network restart
ping www.baidu.com -c 3
#

#https://blog.csdn.net/qq_21398167/article/details/46694179