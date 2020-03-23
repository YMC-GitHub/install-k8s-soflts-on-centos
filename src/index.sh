#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
# import base lib
source "$THIS_FILE_PATH/sh-lib-path-resolve.sh"
source "$THIS_FILE_PATH/config.project.dir.map.sh"
# import some other lib
source "$SRC_PATH/close-firewalld.sh"
source "$SRC_PATH/colse-selinux.sh"
source "$SRC_PATH/colse-swap.sh"
source "$SRC_PATH/install-nfs.sh"
source "$SRC_PATH/open-ipvs.sh"
source "$SRC_PATH/set-sysctl-conf.sh"
source "$SRC_PATH/update-docker-cgroup-driver.sh"
source "$SRC_PATH/install-docker.sh"
source "$SRC_PATH/install-k8s.sh"
