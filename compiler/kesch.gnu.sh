#!/bin/bash

# Basic compiler used for OMNI Compiler compilation
export OMNI_FC="gfortran"
export OMNI_CC="gcc"
export OMNI_CXX="g++"

# MPI wrapper used by OMNI compiler
export OMNI_MPI_CC="MPI_CC=mpicc"
export OMNI_MPI_FC="MPI_FC=mpif90"

export INCLUDE_MPI="/apps/escha/UES/RH6.7/easybuild/software/MVAPICH2/2.2a-GCC-4.9.3-binutils-2.25/include/"
