#!/bin/bash

# Basic compiler used for OMNI Compiler compilation
export OMNI_FC="gfortran"
export OMNI_CC="gcc"
export OMNI_CXX="g++"

# MPI wrapper used by OMNI compiler
export OMNI_MPI_CC="MPI_CC=mpicc"
export OMNI_MPI_FC="MPI_FC=mpif90"

export INCLUDE_MPI="/usr/local/include/"
