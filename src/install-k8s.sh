#!/usr/bin/sh

# 安装软件k8s系列
#软件版本
#K8S_VERSION="1.16.2"
#K8S_VERSION="1.16.0"
K8S_VERSION="1.15.3"
#K8S_VERSION="1.14.3"
#K8S_VERSION="1.10.12"
#K8S_VERSION="1.10.1"

# yum用国内源
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
cat /etc/yum.repos.d/kubernetes.repo
#yum makecache
yum makecache fast
# 查看软件
#2 查看已经安装的
#yum list installed | grep kube
#2 查看可以安装的
#yum list kubectl --showduplicates | sort -r
# 卸载软件
yum remove kubeadm.x86_64 kubectl.x86_64 kubelet.x86_64 -y
# 安装软件
#yum -y install kubernetes-cni = 0.6.0 # fix for K8S_VERSION="1.10.1"
#yum install -y kubelet kubeadm kubectl
yum install -y kubelet-${K8S_VERSION} kubeadm-${K8S_VERSION} kubectl-${K8S_VERSION}
# 查看版本
kubelet --version
kubeadm version
kubectl version
# 配置软件kubelet
::<<note-set-kubelet-eof-2
# docker和kubelet的cgroup driver需要一致
#####
# 替换
#####
# 备份文件
mv --force /usr/lib/systemd/system/docker.service /usr/lib/systemd/system/docker.service.backup
ls /usr/lib/systemd/system/ | grep "backup"
# 替换内容
cat /usr/lib/systemd/system/docker.service | grep "ExecStart=/usr/bin/dockerd"
sed -i "s#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock#& --exec-opt native.cgroupdriver=systemd#" /usr/lib/systemd/system/docker.service
cat /usr/lib/systemd/system/docker.service | grep "ExecStart=/usr/bin/dockerd"

#####
# 测试-替换
#####
#cat /usr/lib/systemd/system/docker.service.backup | grep "ExecStart=/usr/bin/dockerd"
#sed -i "s#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock#& --exec-opt native.cgroupdriver=systemd#" /usr/lib/systemd/system/docker.service.backup
#cat /usr/lib/systemd/system/docker.service.backup | grep "ExecStart=/usr/bin/dockerd"
#####
# 测试-还原
#####
#sed -i "s#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --exec-opt native.cgroupdriver=systemd#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock#" /usr/lib/systemd/system/docker.service.backup
#cat /usr/lib/systemd/system/docker.service.backup | grep "ExecStart=/usr/bin/dockerd"

#####
# 还原文件
#####
# mv --force /usr/lib/systemd/system/docker.service.backup /usr/lib/systemd/system/docker.service

##### 参考
# https://www.kubernetes.org.cn/5650.html
note-set-kubelet-eof-2

# 开机自启kubelet
# 启动软件kubelet
systemctl stop kubelet && systemctl disable kubelet
systemctl enable kubelet && systemctl start kubelet

##### 参考文献
# https://www.kubernetes.org.cn/5650.html
# https://github.com/kubernetes/kubernetes/releases
# https://github.com/kubernetes/dashboard/releases
# kubeadm HA master(v1.13.0)离线包 + 自动化脚本 + 常用插件 For Centos/Fedora
# https://www.kubernetes.org.cn/4948.html
# kubeadm HA master(v1.14.0)离线包 + 自动化脚本 + 常用插件 For Centos/Fedora
# https://www.kubernetes.org.cn/5213.html
# Kubernetes(一) 跟着官方文档从零搭建K8S
