#!/usr/bin/sh

#### 它是什么

#### 为什么要
# 开启ipv6，否则会造成coredns容器无法启动

#### 如何进行
# 设置
::<<set-system-config-for-k8s-way01
# cp /etc/sysctl.conf /etc/sysctl.conf.backup
cat >>/etc/sysctl.conf<< sysctl-conf-eof
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
sysctl-conf-eof
cat /etc/sysctl.conf
sysctl -p
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
set-system-config-for-k8s-way01
# or use below
#::<<set-system-config-for-k8s-way02
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
cat /etc/sysctl.d/k8s.conf
sysctl --system
#set-system-config-for-k8s-way02


# 还原
::<<recover-config-way01
sed -i "s/net.ipv4.ip_forward = 1//g" /etc/sysctl.conf
sed -i "s/net.bridge.bridge-nf-call-ip6tables = 1//g" /etc/sysctl.conf
sed -i "s/net.bridge.bridge-nf-call-iptables = 1//g" /etc/sysctl.conf
sed -i '${/^$/d}' /etc/sysctl.conf
cat /etc/sysctl.conf
recover-config-way01

#### 参考文献
::<<reference
kubeadm安装kubernetes1.13集群
http://www.luyixian.cn/news_show_11429.aspx
reference


