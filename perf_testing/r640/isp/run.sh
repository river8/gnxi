ip netns exec isp ip l set enp59s0f0 netns 1
ip netns exec isp ip l set enp59s0f1 netns 1

ip netns del isp
ip netns add isp

ip l set enp59s0f0 netns isp
ip l set enp59s0f1 netns isp

sysctl -w net.ipv4.ip_forward=1

ip netns exec isp ip a a 10.10.10.11/24 dev enp59s0f0
ip netns exec isp ip a a 20.20.20.20/24 dev enp59s0f1

ip netns exec isp ip l set lo up
ip netns exec isp ip l set enp59s0f0 up
ip netns exec isp ip l set enp59s0f1 up
