#!/bin/bash

# Basic compiler used for OMNI Compiler compilation
export OMNI_FC="gfortran-7"
export OMNI_CC="gcc-7"
export OMNI_CXX="g++-7"

# MPI wrapper used by OMNI compiler
export OMNI_MPI_CC="MPI_CC=mpicc"
export OMNI_MPI_FC="MPI_FC=mpif90"

export INCLUDE_MPI="/usr/local/include/"

export OMNI_CONF="-DOMNI_CONF_OPTION=--with-libxml2=/usr/local/Cellar/libxml2/2.9.7/"
