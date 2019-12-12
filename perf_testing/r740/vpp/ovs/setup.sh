ip netns add ns2
ip l set eno2 netns ns2
ip l set eno4 netns ns2
ip netns exec ns2 ifconfig eno2 up
ip netns exec ns2 ifconfig eno4 up