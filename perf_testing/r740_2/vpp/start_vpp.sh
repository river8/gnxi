ifconfig eno2 down
ip addr flush dev eno2

ifconfig eno3 down
ip addr flush dev eno3

service vpp stop

mkdir -p /tmp/dumps
sysctl -w debug.exception-trace=1
sysctl -w kernel.core_pattern="/tmp/dumps/%e-%t"
ulimit -c unlimited
echo 2 > /proc/sys/fs/suid_dumpable

vpp -c vpp_startup/startup.conf