#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
    set -x
    env | sort
fi

cd $WEST_SIM_ROOT

mkdir -p $(dirname $WEST_ISTATE_DATA_REF)


#Simply copies over the restart file

cp $WEST_BSTATE_DATA_REF/initial.gro $WEST_ISTATE_DATA_REF

