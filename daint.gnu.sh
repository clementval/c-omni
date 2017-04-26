# Basic compiler used for OMNI Compiler compilation
OMNI_FC="ftn"
OMNI_CC="cc"
OMNI_CXX="CC"

# MPI wrapper used by OMNI Compiler
OMNI_MPI_CC="MPI_CC=cc"
OMNI_MPI_FC="MPI_FC=ftn"

# Fix problem finding libxml2
OMNI_CONF="--with-libxml2-lib=/usr/lib64/ --with-libxml2-include=/usr/include/"
