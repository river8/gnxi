mkdir -p db
mkdir -p log
mkdir -p run

export OVS_DBDIR=$PWD/db
export OVS_RUNDIR=$PWD/run
export OVS_LOGDIR=$PWD/log

/usr/share/openvswitch/scripts/ovs-ctl --system-id=random start

ip link set tap0 down
ip link set tap1 down
ip link add type bond mode balance-xor
ip link set tap0 master bond0
ip link set tap1 master bond0

ovs-vsctl add-br dm_carl
ovs-vsctl add-port dm_carl bond0 -- set Interface bond0 ofport_request=200
ovs-vsctl add-port dm_carl eno2 -- set Interface eno2 ofport_request=201
ip l set bond0 up
ip l set tap0 up
ip l set tap1 up
ifconfig eno2 up
ovs-ofctl -OOpenFlow13 del-flows dm_carl
ovs-ofctl -OOpenFlow13 add-flow dm_carl priority=120,in_port=200,actions=output:201
ovs-ofctl -OOpenFlow13 add-flow dm_carl priority=120,in_port=201,actions=output:200
