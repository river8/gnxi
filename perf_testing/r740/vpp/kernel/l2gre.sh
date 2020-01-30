ip netns add ns1
ip link set enp59s0f0 netns ns1
ip link set eno2 netns ns1

ip netns exec ns1 ip a a 20.20.20.21/24 dev enp59s0f0
ip netns exec ns1 ip a a 40.40.40.40/32 dev lo
ip netns exec ns1 ip a a 40.40.40.41/32 dev lo

ip netns exec ns1 ip l set enp59s0f0 up 
ip netns exec ns1 ip l set eno2 up 
ip netns exec ns1 ip l set lo up 

ip netns exec ns1 ip r a default via 20.20.20.20 dev enp59s0f0
ip netns exec ns1 sysctl -w net.ipv4.ip_forward=1

ip netns exec ns1 ip link add gre1 type gretap local 40.40.40.40 remote 30.30.30.31 dev enp59s0f0 ttl 32
ip netns exec ns1 ip link add gre2 type gretap local 40.40.40.41 remote 30.30.30.31 dev enp59s0f0 ttl 32

ip netns exec ns1 ethtool -G eno0 tx 4096 rx 4096
ip netns exec ns1 ethtool -X eno2 weight 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

ip netns exec ns1 ethtool -G enp59s0f0 tx 4096 rx 4096
ip netns exec ns1 ethtool -K enp59s0f0 ntuple on
ip netns exec ns1 ethtool -U enp59s0f0 flow-type ip4 dst-ip 40.40.40.40 action 8
ip netns exec ns1 ethtool -U enp59s0f0 flow-type ip4 dst-ip 40.40.40.41 action 10
ip netns exec ns1 ethtool -X enp59s0f0 weight  0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

ip netns exec ns1 ./ovs.sh
