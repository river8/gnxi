ip l set tap0 up
ip a a 172.16.1.2/24 dev tap0
ip r a default via 172.16.1.1 dev tap0