# This file defines where WEST and GROMACS can be found
# Modify to taste
        
# Load the modules!
 #module load anaconda-python/2.7.10
 module load gromacs/compute/5.1.1
 module load hdf5/intel

# Where to fund WESTPA
 export WEST_ROOT=/home-1/dmohamm2\@jhu.edu/dariush/westpa/westpa

# Where to find Anaconda Python
 export WEST_PYTHON=/home-1/dmohamm2@jhu.edu/anaconda2/bin/python

# Set environment variables for Gromacs for convenience
 export GROMPP="gmx_mpi grompp"
 export MDRUN="gmx_mpi mdrun"
 export NODELOC=$LOCAL

# ZMQ
 export WM_ZMQ_MASTER_HEARTBEAT=100
 export WM_ZMQ_WORKER_HEARTBEAT=100
 export WM_ZMQ_TIMEOUT_FACTOR=100

# Explicitly name our simulation root directory
 if [[ -z "$WEST_SIM_ROOT" ]]; then
     export WEST_SIM_ROOT="$PWD"
 fi

 
# Set simulation name
 export SIM_NAME=$(basename $WEST_SIM_ROOT)
 echo "simulation $SIM_NAME root is $WEST_SIM_ROOT"


# Setting variables for use in runseg.sh and get_pcoord.sh.
 export G_DIST="gmx_mpi distance"
 export G_RMS="gmx_mpi rms"
 export TRJCONV="gmx_mpi trjconv"
 export GMINDIST="gmx_mpi mindist"
 export GRAMA="gmx_mpi rama"
 export GMX_CFG=$WEST_SIM_ROOT/gromacs_config/
# export TOP_LOC=$WEST_SIM_ROOT/gromacs_config/topol.top
# export ITP_LOC=$WEST_SIM_ROOT/gromacs_config/Protein_A.itp
# export ION_LOC=$WEST_SIM_ROOT/gromacs_config/ions.itp
# export NDX_LOC=$WEST_SIM_ROOT/gromacs_config/index.ndx
# export REF_LOC=$WEST_SIM_ROOT/gromacs_config/coil.gro
# export MDP_LOC=$WEST_SIM_ROOT/gromacs_config/md.mdp
 export TOP=$WEST_SIM_ROOT/gromacs_config/topol.top
 export NDX=$WEST_SIM_ROOT/gromacs_config/index.ndx
# export REF=coil.gro
# export MDP=md.mdp
