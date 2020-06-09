#!/bin/sh

SESSIONNAME="work"
TMUX="tmux"

$TMUX has-session -t $SESSIONNAME > /dev/null 2>&1

if [ $? != 0 ]
then
  $TMUX new-session -d -s $SESSIONNAME -n src
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX select-pane -t 0

  $TMUX new-window -t $SESSIONNAME:2 -n test
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX split-window -h -t $SESSIONNAME:2
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX select-pane -t 0

  $TMUX new-window -t $SESSIONNAME:3 -n vpp
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX split-window -h -t $SESSIONNAME:3
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX split-window -v -t $SESSIONNAME:3
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX select-pane -t 0

  $TMUX new-window -t $SESSIONNAME:4 -n monitoring
  $TMUX send-keys 'cd /home/esdn/gnxi/perf_testing/r440/vpp' 'C-m'
  $TMUX select-pane -t 0

  $TMUX select-window -t $SESSIONNAME:1
fi

$TMUX attach -t $SESSIONNAME
