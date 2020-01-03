mkdir -p db
mkdir -p log
mkdir -p run

export OVS_DBDIR=$PWD/db
export OVS_RUNDIR=$PWD/run
export OVS_LOGDIR=$PWD/log

/usr/share/openvswitch/scripts/ovs-ctl --system-id=random start

ovs-vsctl add-br br1
ovs-vsctl add-port br1 gre1 -- set Interface gre1 ofport_request=200
ovs-vsctl add-port br1 eno2 -- set Interface eno2 ofport_request=201
ovs-vsctl add-port br1 gre2 -- set Interface gre2 ofport_request=202

ip l set gre1 up
ip l set gre2 up
ip l set eno2 up

ovs-ofctl -OOpenFlow13 del-flows br1
ovs-ofctl -OOpenFlow13 add-group br1 group_id=1,type=select,bucket=output:200,bucket=output:202
ovs-ofctl -OOpenFlow13 add-flow br1 priority=120,in_port=200,actions=output:201
ovs-ofctl -OOpenFlow13 add-flow br1 priority=120,in_port=202,actions=output:201
ovs-ofctl -OOpenFlow13 add-flow br1 in_port=201,actions=group:1
