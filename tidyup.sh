#!/bin/bash
# Deletes old trajectory segments and log files.
# Written 120906 by Brandon Mills.

source env.sh

#Delete Old Iterations and Seg_Logs
ITER=$[WEST_CURRENT_ITER-2]
echo "iter: $WEST_CURRENT_ITER"
if [[ $ITER -ge 1 ]] ; then
echo "removing logs for iter: $ITER"
ITER_FORMAT=$(printf "%06d" $ITER)
echo "iter formatted as: $ITER_FORMAT"
rm -rfv $WEST_SIM_ROOT/traj_segs/$ITER_FORMAT
rm -rfv $WEST_SIM_ROOT/seg_logs/$ITER_FORMAT-*
fi;
# A test for analysis, not fit for all systems
# especially ones with large h5 files.
mv $WEST_SIM_ROOT/west.h5.bckup1 $WEST_SIM_ROOT/west.h5.bckup2 
cp $WEST_SIM_ROOT/west.h5 $WEST_SIM_ROOT/west.h5.bckup1
echo $WEST_CURRENT_ITER > $WEST_SIM_ROOT/cur_iter.txt
