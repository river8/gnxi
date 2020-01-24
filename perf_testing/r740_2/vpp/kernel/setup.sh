ip netns add ns1

ip l set eno2 netns ns1
ip l set enp59s2f1 netns ns1

# ip netns exec ns1 ethtool -G eno2 rx 4096
# ip netns exec ns1 ethtool -G eno2 tx 4096
# ip netns exec ns1 ethtool -G enp25s16f2 rx 4096
# ip netns exec ns1 ethtool -G enp25s16f2 tx 4096

ip netns exec ns1 ip a a 30.30.30.31/24 dev enp59s2f1
# ip netns exec ns1 ip a a 192.16.2.1/24 dev eno2

ip netns exec ns1 ip l set enp59s2f1 up
ip netns exec ns1 ip l set eno2 up

ip netns exec ns1 ip r a default via 30.30.30.30 dev enp59s2f1
ip netns exec ns1 sysctl -w net.ipv4.ip_forward=1

ip netns exec ns1 ip link add gre1 type gretap local 30.30.30.31 remote 20.20.20.21 dev enp59s2f1 ttl 32