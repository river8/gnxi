ip netns add ns1

ip l set eno2 netns ns1
ip l set enp59s0f0 netns ns1

ip netns exec ns1 ethtool -G eno2 rx 4096 tx 4096
ip netns exec ns1 ethtool -G enp59s0f0 rx 4096 tx 4096

ip netns exec ns1 ip l set enp59s0f0 up
ip netns exec ns1 ip l set eno2 up

ip netns exec ns1 ethtool -X enp59s0f0 weight 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1
ip netns exec ns1 ethtool -X eno2 weight 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1

ip netns exec ns1 ./ovs.sh