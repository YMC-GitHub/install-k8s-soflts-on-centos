#!/bin/sh

#### ipvs它是什么

#### ipvs为什么要
#k8s master的高可用和集群服务的负载均衡要用到ipvs

# 检查开启状态
cut -f1 -d " " /proc/modules | grep -e ip_vs -e nf_conntrack_ipv4
if [ $? -eq 0 ]; then
    echo "has been onpend before" >/dev/null 2>&1
else
    # 若没则开启它
    modprobe -- ip_vs
    modprobe -- ip_vs_rr
    modprobe -- ip_vs_wrr
    modprobe -- ip_vs_sh
    modprobe -- nf_conntrack_ipv4
    yum install ipset -y
fi

#### 参考文献
: <<reference
kubeadm安装kubernetes1.13集群
http://www.luyixian.cn/news_show_11429.aspx
reference
