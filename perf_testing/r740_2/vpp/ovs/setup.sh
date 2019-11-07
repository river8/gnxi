ip netns add ns1
ip l set eno2 netns ns1
ip l set eno3 netns ns1
ip netns exec ns1 ifconfig eno2 up
ip netns exec ns1 ifconfig eno3 up