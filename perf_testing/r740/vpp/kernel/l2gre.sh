ip netns add ns1
ip link set enp27s16f2 netns ns1
ip link set eno2 netns ns1

ip netns exec ns1 ip a a 20.20.20.21/24 dev enp27s16f2
ip netns exec ns1 ip a a 40.40.40.40/32 dev lo
ip netns exec ns1 ip a a 40.40.40.41/32 dev lo

ip netns exec ns1 ip l set enp27s16f2 up 
ip netns exec ns1 ip l set eno2 up 
ip netns exec ns1 ip l set lo up 

ip netns exec ns1 ip r a default via 20.20.20.20 dev enp27s16f2
ip netns exec ns1 sysctl -w net.ipv4.ip_forward=1

ip netns exec ns1 ip link add gre1 type gretap local 40.40.40.40 remote 30.30.30.31 dev enp27s16f2 ttl 32
ip netns exec ns1 ip link add gre2 type gretap local 40.40.40.41 remote 30.30.30.31 dev enp27s16f2 ttl 32
ip netns exec ns1 ./ovs.sh
