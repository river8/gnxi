ifconfig eno2 down
ip addr flush dev eno2

ifconfig eno3 down
ip addr flush dev eno3

service vpp stop
vpp -c vpp_startup/startup.conf