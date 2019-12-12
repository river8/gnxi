ifconfig eno2 down
ip addr flush dev eno2

#ip netns add ns1
#ip link set eno2 netns ns1
#ip netns exec ns1 ifconfig eno2 up

#ifconfig eno4 down
#ip addr flush dev eno4

ifconfig enp27s16f1 down
ip addr flush dev enp27s16f1

service vpp stop

mkdir -p /tmp/dumps
sysctl -w debug.exception-trace=1
sysctl -w kernel.core_pattern="/tmp/dumps/%e-%t"
ulimit -c unlimited
echo 2 > /proc/sys/fs/suid_dumpable

vpp -c vpp_startup/startup.conf