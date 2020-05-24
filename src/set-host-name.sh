#!/bin/sh

VM_HOST_NAME=k8s-master
VM_HOST_IP_NAME_MAP=
function set_host_name() {
  # 设置
  #2 for centos7
  hostnamectl set-hostname $VM_HOST_NAME
  #2 for centos6
  #hostname $VM_HOST_NAME

  # 查看
  cat /etc/hostname

  # 设置
  #cat /etc/hosts | grep "127.0.0.1" | grep "${VM_HOST_NAME}" > /dev/null 2>&1

  #echo  "no"
  # 在匹配的行前添加#(注释)
  #sed  '/127.0.0.1 */ s/^/#/g' /etc/hosts
  # 在匹配的行后添加（追加）
  #sed -i "/127.0.0.1 */ s/$/ $VM_HOST_NAME/g" /etc/hosts
  # 删除后添加（覆盖）
  #sed "s/127.0.0.1.*//g" /etc/hosts | sed '/^\s*$/d'
  sed -i "s/127.0.0.1.*//g" /etc/hosts
  sed -i '/^\s*$/d' /etc/hosts
  echo "127.0.0.1 $VM_HOST_NAME" >>/etc/hosts

  #cat /etc/hosts | grep "::1" | grep $VM_HOST_NAME > /dev/null 2>&1
  #echo  "no"
  # 在匹配的行前添加#
  #sed  '/::1 */ s/^/#/g' /etc/hosts
  # 在匹配的行后添加#
  #sed -i "/::1 */ s/$/ $VM_HOST_NAME/g" /etc/hosts
  sed -i "s/::1.*//g" /etc/hosts
  sed -i '/^\s*$/d' /etc/hosts
  echo "::1 $VM_HOST_NAME" >>/etc/hosts

  # 查看
  cat /etc/hosts
}
set_host_name


# set dns resolve on centos
VM_HOST_IP_NAME_MAP=$(cat <<EOF
192.168.56.2 $VM_HOST_NAME
EOF
)
echo "$VM_HOST_IP_NAME_MAP" >>/etc/hosts
sed -i "/^$/d" /etc/hosts
tail -3 /etc/hosts