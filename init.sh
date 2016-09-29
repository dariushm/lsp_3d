#!/bin/bash

#Initialize LSPs simulation

source env.sh

rm -f west.h5 
rm -Rf traj_segs; mkdir traj_segs
rm -Rf seg_logs; mkdir seg_logs; 
rm -Rf job_logs; mkdir job_logs
rm -Rf istates; mkdir istates

BSTATE_ARGS="--bstate-file $WEST_SIM_ROOT/initdist.file"
TSTATE_ARGS="--tstate-file $WEST_SIM_ROOT/target.file"
$WEST_ROOT/bin/w_init $BSTATE_ARGS $TSTATE_ARGS --segs-per-state 1 \
  --work-manager=serial "$@"


