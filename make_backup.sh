#!/bin/bash
# make-backup.sh
# Generate restart files, in case of h5file corruption.
# Written by Brandon Mills on 120619.

# env.cfg.sh Variables: BAK_DIR, BAK_NUM, BAK_FREQ, DIR_SEGMENTS, H5_NAME

ENV_SRC=config/env.cfg.sh
source $ENV_SRC

ITER=$[WEST_CURRENT_ITER-1];

if (( $BAK_NUM == 0 )) ; then
   exit 1;
fi;

if (( $ITER == 0)) ; then
   exit 1;
fi;

#If the current iteration is a multiple of the frequency variable, make a backup.
if (( $ITER % $BAK_FREQ == 0 )) ; then   #Even Divisibility Check
    #Make the backup directory.
    NEW_BKUP_DIR=$BAK_DIR/$(printf "%06d" $ITER);
    /bin/mkdir -p $NEW_BKUP_DIR;
    /bin/mkdir -p $NEW_BKUP_DIR/$DIR_SEGMENTS;

    #Copy to the backup directory: h5file and traj_segs.
    /bin/cp $H5_NAME $NEW_BKUP_DIR;
    /bin/cp -r $WEST_SIM_ROOT/$DIR_SEGMENTS/$(printf "%06d" $ITER) $NEW_BKUP_DIR/$DIR_SEGMENTS/;

    #Delete a previous backup directory.
    N_ITER_AGO=$[$BAK_NUM*$BAK_FREQ];
    if [ "$ITER" -ge "$N_ITER_AGO" ] ; then
        OLD_BKUP=$[$ITER-$N_ITER_AGO];
        OLD_BKUP_DIR=$BAK_DIR/$(printf "%06d" $OLD_BKUP);
        /bin/rm -rf $OLD_BKUP_DIR;
    fi;
fi;
