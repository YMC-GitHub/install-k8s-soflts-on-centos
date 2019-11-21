#!/usr/bin/sh

#软件版本
DOCKER_VERSION="18.09.9"
#DOCKER_VERSION="18.09.8"
#DOCKER_VERSION="18.09.3"

#sudo -i
# 卸载软件docker
yum remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-engine
# 安装工具
yum install -y yum-utils \
device-mapper-persistent-data \
lvm2
# 设安装源
yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
ls /etc/yum.repos.d/ | grep docker-ce.repo
#yum-config-manager --enable docker-ce-nightly
#yum-config-manager --enable docker-ce-test
yum-config-manager --disable docker-ce-nightly
yum-config-manager --enable docker-ce-test
#2 用阿里云
wget -O /etc/yum.repos.d/CentOS-aliyun-docker-ce.repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
ls /etc/yum.repos.d/ | grep CentOS-aliyun-docker-ce.repo
#yum makecache
yum makecache fast
# 搜索软件docker
yum list docker-ce --showduplicates | sort -r # 列出可装版本
# 安装软件docker
#yum install docker-ce -y
#2 安装指定版本
#yum install -y docker-ce-18.09.7
#yum install -y docker-ce-${DOCKER_VERSION}
yum install docker-ce-${DOCKER_VERSION} docker-ce-cli-${DOCKER_VERSION} containerd.io

docker --version
# 配置软件docker
:: <<set-docker-config
mkdir -p /etc/docker
# docker和kubelet的cgroup driver需要一致
cat >>/etc/docker/daemon.json<<docker-daemon-config
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
docker-daemon-config
cat /etc/docker/daemon.json
#like to use Docker as a non-root user
#DOCKER_USER=docker
#usermod -aG docker $DOCKER_USER
systemctl enable docker &&systemctl start docker
set-docker-config
# 启动服务docker
# 开机自启docker
systemctl stop docker && systemctl disable docker
systemctl enable docker && systemctl start docker

# 测试运行docker
# docker run --rm hello-world

# 卸载清除docker
:: <<delete-docker
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
# https://www.cnblogs.com/EasonJim/p/9987947.html
delete-docker

##########
# reference
##########
# Get Docker Engine - Community for CentOS
# https://docs.docker.com/install/linux/docker-ce/centos/
# CentOS7安装特定版本的Docker
# https://www.cnblogs.com/liuxiutianxia/p/8857141.html
# 三步搞定Centos 7 上特定版本的 docker 安装
# https://www.cnblogs.com/dw039/p/9392458.html
# Kubernetes(一) 跟着官方文档从零搭建K8S
# https://juejin.im/post/5d7fb46d5188253264365dcf
