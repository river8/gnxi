#!/bin/bash

ip netns add ns1

ip link add link eno3 name eno3.3010 type vlan id 3010
ip link add link eno3 name eno3.3000 type vlan id 3000

ip link set eno3.3010 up

ip link set eno3.3000 netns ns1

ip netns exec ns1 ip addr add 10.10.10.10/24 dev eno3.3000
ip netns exec ns1 ip link set eno3.3000 up

ip netns exec ns1 ip l set lo up