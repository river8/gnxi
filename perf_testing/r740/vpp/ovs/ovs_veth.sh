mkdir -p db
mkdir -p log
mkdir -p run

export OVS_DBDIR=$PWD/db
export OVS_RUNDIR=$PWD/run
export OVS_LOGDIR=$PWD/log

/usr/share/openvswitch/scripts/ovs-ctl --system-id=random start

ovs-vsctl add-br dm_carl
ovs-vsctl add-port dm_carl veth0 -- set Interface veth0 ofport_request=200
ovs-vsctl add-port dm_carl eno2 -- set Interface eno2 ofport_request=201
ip l set veth0 up
ip l set eno2 up
ovs-ofctl -OOpenFlow13 del-flows dm_carl
ovs-ofctl -OOpenFlow13 add-flow dm_carl priority=120,in_port=200,actions=output:201
ovs-ofctl -OOpenFlow13 add-flow dm_carl priority=120,in_port=201,actions=output:200
