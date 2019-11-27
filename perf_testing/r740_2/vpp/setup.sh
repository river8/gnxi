ip netns add ns1
ip link add veth0 type veth peer name veth1
ip link set veth0 netns ns1
ip netns exec ns1 ip link set dev veth0 address d6:4b:87:30:6a:61
ip netns exec ns1 ip link set veth0 up
ip netns exec ns1 ip a a 172.16.2.2/24 dev veth0
ip netns exec ns1 ip r a default via 172.16.2.1 dev veth0
ip netns exec ns1 ip l set lo up