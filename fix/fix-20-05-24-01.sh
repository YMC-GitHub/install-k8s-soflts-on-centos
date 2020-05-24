#!/bin/sh

# fix:Another app is currently holding the yum lock; waiting for it to exit…

# ps aux | grep yum
# yumid=3940  && kill -s 9 "$yumid"
# yumid=4128  && kill -s 9 "$yumid"
# yumid=4293  && kill -s 9 "$yumid"
# yumid=4489  && kill -s 9 "$yumid"
# yumid=4597  && kill -s 9 "$yumid"



rm -f /var/run/yum.pid