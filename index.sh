#!/bin/sh

./close-firewalld.sh
./colse-selinux.sh
./colse-swap.sh
./install-nfs.sh
./open-ipvs.sh
./set-sysctl-conf.sh
./update-docker-cgroup-driver.sh
./install-docker.sh
./install-k8s.sh
