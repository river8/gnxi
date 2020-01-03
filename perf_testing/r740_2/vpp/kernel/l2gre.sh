ip netns add ns1

ip l set eno2 netns ns1
ip l set enp25s16f2 netns ns1

ip netns exec ns1 ip a a 30.30.30.31/24 dev enp25s16f2

ip netns exec ns1 ip l set enp25s16f2 up
ip netns exec ns1 ip l set eno2 up

ip netns exec ns1 ip link add gre1 type gretap local 30.30.30.31 remote 40.40.40.40 dev enp25s16f2 ttl 33
ip netns exec ns1 ip link add gre2 type gretap local 30.30.30.31 remote 40.40.40.41 dev enp25s16f2 ttl 33

ip netns exec ns1 ip r a default via 30.30.30.30 dev enp25s16f2
ip netns exec ns1 sysctl -w net.ipv4.ip_forward=1

ip netns exec ns1 ./ovs.sh