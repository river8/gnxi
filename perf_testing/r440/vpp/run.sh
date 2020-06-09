ip netns del apps
ip netns del west 

ip netns add apps
ip netns add west

ip link add veth0 type veth peer name veth1
ip link add veth2 type veth peer name veth3
ip l set veth0 netns apps
ip l set veth2 netns west
