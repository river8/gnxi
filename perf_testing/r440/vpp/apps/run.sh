ip l set veth0 down
ip l set veth0 addr 22:85:1f:20:06:d5
ip a a 10.10.10.10/24 dev veth0
ip r a default via 10.10.10.11 dev veth0
ip l set veth0 up
ip l set lo up

for intf in "veth0"
do
  echo "Disable optimization for" $intf
  ethtool --offload $intf rx off tx off
  ethtool -k $intf | grep segmentation

  ethtool -K $intf tso off
  ethtool -K $intf sg off
  ethtool -k $intf | grep scatter-gather

  ethtool -K $intf gso off
done
