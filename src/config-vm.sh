# config master vm
# config worker vm
hostname
cat /etc/redhat-release
lscpu | grep "CPU(s)"

hostnamectl set-hostname k8s-worker1
hostnamectl status
echo "127.0.0.1   $(hostname)" >> /etc/hosts

# solft version
hostname --version
hostnamectl --version
tail --version
systemctl --version
sed --version
swapoff --version
cat --version
yum --version
iptables --version

# set host name on centos
hostname k8s-master
hostnamectl set-hostname k8s-master
hostname k8s-node1
hostnamectl set-hostname k8s-node1
# set host ip on centos

# set dns resolve on centos
echo "192.168.1.3 k8s-master" >>/etc/hosts
echo "192.168.1.4 k8s-node1" >>/etc/hosts
tail -3 /etc/hosts

# close firewalld  on centos
systemctl stop firewalld
systemctl disable firewalld

# close selinux  on centos
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
setenforce 0

# colse swap on centos
swapoff -a
cat /etc/fstab
cat /etc/fstab | grep " swap " | grep "^#"
if [ $? -eq 0 ]
then
    echo "has comment with #" > /dev/null 2>&1
else
    sed -i '/ swap / s/^/#/' /etc/fstab
fi


# set time is the same in difference centos vm
yum install ntp wget -y
ntpdate ntp.api.bz
#ntpdate ntp1.aliyun.com

# set ipv4 for iptables
cat >>/etc/sysctl.conf<< sysctl-conf-eof
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
sysctl-conf-eof
cat /etc/sysctl.conf
sysctl -p
# or use below
::<<note-eof
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
note-eof
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables

# check ip and mac
cat /sys/class/dmi/id/product_uuid
ip link
#ifconfig -a

#### 参考文献
# kubeadm HA master(v1.13.0)离线包 + 自动化脚本 + 常用插件 For Centos/Fedora
# 
