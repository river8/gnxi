iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain

iptables -t nat -A POSTROUTING -o enp59s0f1 -j MASQUERADE -p udp --sport 500 --to-ports 500
iptables -t nat -A POSTROUTING -o enp59s0f1 -j MASQUERADE -p udp --to-ports 1024-31000
iptables -t nat -A POSTROUTING -o enp59s0f1 -j MASQUERADE

if iptables -N NAT; then
  iptables -I FORWARD -j NAT
fi

iptables -A NAT -i enp59s0f1 -o enp59s0f0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A NAT -i enp59s0f0 -o enp59s0f1 -j ACCEPT
