ethtool -N enp175s0f2 rx-flow-hash tcp4 sdfn
ethtool -N enp175s0f2 rx-flow-hash tcp6 sdfn
ethtool -N enp175s0f2 rx-flow-hash udp4 sdfn
ethtool -N enp175s0f2 rx-flow-hash udp6 sdfn
ethtool -K enp175s0f2 rxhash on
ethtool -G enp175s0f2 rx 4096 tx 4096

# 8, 10, 12
ethtool -X enp175s0f2 weight 0 0 0 0 0 0 0 0 1 0 1 0 1
