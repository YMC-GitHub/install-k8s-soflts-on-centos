#!/bin/sh
# 关闭服务
systemctl stop docker
# 开机关闭
systemctl disable docker
#rm -rf /etc/systemd/system/docker.service.d

# 删安装包
yum list installed | grep docker
rpm -qa | grep docker*
yum remove docker
yum remove -y docker-ce-cli
# 删除镜像
rm -rf /var/lib/docker
rm -rf /var/run/docker
docker --version

#### 遇到问题
#
# 问题：rm: cannot remove ‘/var/run/docker/netns/default’: Device or resource busy
# 解决：https://blog.csdn.net/qq_28284093/article/details/80117367
# 参考：
# umount /var/run/docker/netns/default

##########
# reference
##########
# 干净的卸载docker （适用centos7）
# https://blog.csdn.net/weixin_39592623/article/details/88060629
# centos7下卸载docker
# https://blog.csdn.net/x15011238662/article/details/84963439
# CentOS 7卸载Docker
