#!/bin/bash

rmmod i40e; modprobe i40e
modprobe uio_pci_generic
modprobe vfio_pci

mkdir -p /tmp/dumps
sysctl -w debug.exception-trace=1
sysctl -w kernel.core_pattern="/tmp/dumps/%e-%t"
ulimit -c unlimited
echo 2 > /proc/sys/fs/suid_dumpable

vpp -c startup.conf