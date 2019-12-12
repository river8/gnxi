export OVS_DBDIR=$PWD/db
export OVS_RUNDIR=$PWD/run
export OVS_LOGDIR=$PWD/log

ovs-vsctl del-br dm_mm
/usr/share/openvswitch/scripts/ovs-ctl stop
