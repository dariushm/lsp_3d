#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
    set -x
    env | sort
fi

cd $WEST_SIM_ROOT


# Set up the run
mkdir -pv $WEST_CURRENT_SEG_DATA_REF
cd $WEST_CURRENT_SEG_DATA_REF
cp $WEST_SIM_ROOT/gromacs_config/*.* .

case $WEST_CURRENT_SEG_INITPOINT_TYPE in
    SEG_INITPOINT_CONTINUES)
    cp $WEST_PARENT_DATA_REF/seg.gro ./parent.gro
    $GROMPP -f md_cont.mdp -c parent.gro -t parent.cpt -p $TOP -n $NDX\
          -o seg.tpr -po md_out.mdp -maxwarn 10   ;;

    SEG_INITPOINT_NEWTRAJ)
    cp $WEST_PARENT_DATA_REF/initial.gro ./parent.gro
    
    rand=$RANDOM
    sed "51s/.*/gen_seed                 = $rand/" md_new.mdp > md_new_rand.mdp
    
    $GROMPP -f md_new_rand.mdp -c parent.gro -p $TOP -n $NDX\
	-o seg.tpr -po md_out.mdp -maxwarn 10    ;;

    *)
        echo "unknown init point type $WEST_CURRENT_SEG_INITPOINT_TYPE"
        exit 2
    ;;
esac


# Propagate segment
# It's easiest to set our OpenMP thread count manually here.
export OMP_NUM_THREADS=1

    $MDRUN -v -s seg.tpr -deffnm seg


# Calculate progress coordinate
    $GMINDIST -f seg.xtc -s em_w.tpr -od mindist.xvg -xvg none -n $NDX -nice 19 -pbc <<< "15 16" || exit 1
    cat mindist.xvg | awk '{print $2*10;}' > $WEST_PCOORD_RETURN


