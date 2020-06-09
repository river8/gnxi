#!/bin/bash

ifconfig enp59s0f0 down
ip addr flush dev enp59s0f0

ifconfig enp175s0f2 down
ip addr flush dev enp175s0f2

rmmod i40e; modprobe i40e
modprobe uio_pci_generic
modprobe vfio_pci

mkdir -p /tmp/dumps
sysctl -w debug.exception-trace=1
sysctl -w kernel.core_pattern="/tmp/dumps/%e-%t"
ulimit -c unlimited
echo 2 > /proc/sys/fs/suid_dumpable

vpp -c startup.conf
