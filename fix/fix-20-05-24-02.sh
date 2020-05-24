#!/bin/sh

# fix:curl#6 - "Could not resolve host: mirrors.tuna.tsinghua.edu.cn; 未知的错误"

# ps aux | grep yum
# yumid=3940  && kill -s 9 "$yumid"
# yumid=4128  && kill -s 9 "$yumid"
# yumid=4293  && kill -s 9 "$yumid"
# yumid=4489  && kill -s 9 "$yumid"
# yumid=4597  && kill -s 9 "$yumid"


cat  /etc/resolv.conf
cat > /etc/resolv.conf << eof
nameserver 8.8.8.8
nameserver 114.114.114.114
eof
cat /etc/resolv.conf