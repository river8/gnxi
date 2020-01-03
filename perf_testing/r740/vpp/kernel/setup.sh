ip netns add ns1
ip link set enp27s16f2 netns ns1
ip link set eno2 netns ns1

ip netns exec ns1 ethtool -G eno2 rx 4096
ip netns exec ns1 ethtool -G enp27s16f2 rx 4096
ip netns exec ns1 ethtool -G eno2 tx 4096
ip netns exec ns1 ethtool -G enp27s16f2 tx 4096

ip netns exec ns1 ip a a 20.20.20.21/24 dev enp27s16f2
iip netns exec ns1 p a a 192.16.1.1/24 dev eno2

ip netns exec ns1 ip l set enp27s16f2 up 
ip netns exec ns1 ip l set eno2 up 

ip netns exec ns1 ip r a default via 20.20.20.20 dev enp27s16f2
ip netns exec ns1 sysctl -w net.ipv4.ip_forward=1
