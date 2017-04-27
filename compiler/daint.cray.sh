# Basic compiler used for OMNI Compiler compilation
OMNI_FC="ftn"
OMNI_CC="cc"
OMNI_CXX="CC"

# MPI wrapper used by OMNI compiler
OMNI_MPI_CC="MPI_CC=cc"
OMNI_MPI_FC="MPI_FC=ftn"

# Switch to dynamic linking
export CRAYPE_LINK_TYPE=dynamic
