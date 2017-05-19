#!/bin/bash

# Basic compiler used for OMNI Compiler compilation
export OMNI_FC="ftn"
export OMNI_CC="cc"
export OMNI_CXX="CC"

# MPI wrapper used by OMNI compiler
export OMNI_MPI_CC="MPI_CC=cc"
export OMNI_MPI_FC="MPI_FC=ftn"

# Switch to dynamic linking
export CRAYPE_LINK_TYPE=dynamic

export INCLUDE_MPI="/usr/local/include/"
