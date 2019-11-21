#!/usr/bin/sh

#### 它是什么

#### 为什么要

#### 如何进行

##########
#设置
#########
# 对它进行关闭
swapoff -a
# 防止开机自启
#2查看修改前的
cat /etc/fstab
cat /etc/fstab | grep " swap " | grep "^#"
if [ $? -eq 0 ]; then
    echo "has comment with #" >/dev/null 2>&1
else
    sed -i '/ swap / s/^/#/' /etc/fstab
fi
#2查看修改后的
cat /etc/fstab

##########
#还原
#########

#### 参考文献
:: <<reference
kubeadm安装kubernetes1.13集群
http://www.luyixian.cn/news_show_11429.aspx
reference
