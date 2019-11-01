#!/bin/bash

ip netns exec ns1 ip link set eno3.3000 down
ip netns exec ns1 ip link set eno3.3000 netns 1
ip link set eno3.3010 down

ip link delete eno3.3010
ip link delete eno3.3000

ip netns del ns1