rmmod i40e; modprobe i40e
modprobe uio_pci_generic
modprobe vfio_pci

ifconfig enp59s0f3 down
ip addr flush dev enp59s0f3

ifconfig enp59s0f1 down
ip addr flush dev enp59s0f1

mkdir -p /tmp/dumps
sysctl -w debug.exception-trace=1
sysctl -w kernel.core_pattern="/tmp/dumps/%e-%t"
ulimit -c unlimited
echo 2 > /proc/sys/fs/suid_dumpable

vpp -c vpp_startup/startup.conf