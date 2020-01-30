mkdir -p db
mkdir -p log
mkdir -p run

export OVS_DBDIR=$PWD/db
export OVS_RUNDIR=$PWD/run
export OVS_LOGDIR=$PWD/log

/usr/share/openvswitch/scripts/ovs-ctl --system-id=random start

ovs-vsctl add-br br1
ovs-vsctl add-port br1 eth0.100 -- set Interface eth0.100 ofport_request=200
ovs-vsctl add-port br1 eno2 -- set Interface eno2 ofport_request=201

ip l set eth0.100 up
ip l set eno2 up

ovs-ofctl -OOpenFlow13 del-flows br1
# ovs-ofctl -OOpenFlow13 add-flow br1 priority=120,in_port=200,dl_vlan=100,actions=pop_vlan,output:201
ovs-ofctl -OOpenFlow13 add-flow br1 priority=120,in_port=201,actions=output:200
ovs-ofctl -OOpenFlow13 add-flow br1 priority=120,in_port=200,actions=output:201