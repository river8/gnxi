ifconfig eno2 down
ip addr flush dev eno2

ifconfig eno4 down
ip addr flush dev eno4

service vpp stop
vpp -c vpp_startup/startup.conf