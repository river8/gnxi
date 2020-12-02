vpp -c startup.conf.crash &

sleep 2

prlimit -p $(pidof vpp) --core=unlimited
vppctl show clock
vppctl set ikev2 local key secrets/srv-2-key.pem

vppctl set int state eth1 up
vppctl create sub-interfaces eth1 100
vppctl set interface l2 tag-rewrite eth1.100 pop 1
vppctl set int state eth1.100 up

vppctl create gre tunnel src 10.10.10.11 dst 10.10.10.10 teb

vppctl set interface l2 xconnect gre0 eth1.100
vppctl set interface l2 xconnect eth1.100 gre0 

vppctl ikev2 profile add pr0
vppctl ikev2 profile set pr0 tunnel gre0
vppctl ikev2 profile set pr0 auth rsa-sig cert-file secrets/r440-cert.pem
vppctl ikev2 profile set pr0 id remote fqdn r440
vppctl ikev2 profile set pr0 id local fqdn srv-2
vppctl ikev2 profile set pr0 traffic-selector remote ip-range 0.0.0.0-255.255.255.255 port-range 0 - 65535 protocol 0
vppctl ikev2 profile set pr0 traffic-selector local ip-range 0.0.0.0-255.255.255.255 port-range 0 - 65535 protocol 0

sleep 0.1


vppctl create gre tunnel src 10.10.10.11 dst 10.10.10.20 teb

vppctl set int state eth1 up
vppctl create sub-interfaces eth1 101
vppctl set interface l2 tag-rewrite eth1.101 pop 1
vppctl set int state eth1.101 up

vppctl set interface l2 xconnect gre1 eth1.101
vppctl set interface l2 xconnect eth1.101 gre1

vppctl ikev2 profile add pr1
vppctl ikev2 profile set pr1 tunnel gre1
vppctl ikev2 profile set pr1 auth rsa-sig cert-file secrets/r440-cert.pem
vppctl ikev2 profile set pr1 id remote fqdn r440
vppctl ikev2 profile set pr1 id local fqdn srv-2
vppctl ikev2 profile set pr1 traffic-selector remote ip-range 0.0.0.0-255.255.255.255 port-range 0 - 65535 protocol 0
vppctl ikev2 profile set pr1 traffic-selector local ip-range 0.0.0.0-255.255.255.255 port-range 0 - 65535 protocol 0
