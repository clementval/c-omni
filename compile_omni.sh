#!/bin/bash

#
# This scripts to compile OMNI Compiler for the parsing tests.
#

function show_help(){
  echo "$0 [-r <repository-url>] [-b <branch-name>] [-c gnu|pgi|cray]"
  echo ""
  echo "Options:"
  echo " -r <repository-url> Specify the URL of the GIT repository"
  echo " -b <branch-name>    Specify the branch to be tested"
  echo " -c <compiler-id>    Define the base compiler to use"
}

# Define default local variable
OMNI_BRANCH="master"
OMNI_REPO="https://github.com/omni-compiler/omni-compiler.git"
BASE_COMPILER="gnu"
OMNI_FC="gfortran"
OMNI_CC="gcc"
OMNI_CXX="g++"
OMNI_MPI_CC="mpicc"
OMNI_MPI_FC="mpif90"

COMPUTER=$(hostname)

while getopts "hb:c:r:" opt; do
  case "$opt" in
  h)
    show_help
    exit 0
    ;;
  b)
    OMNI_BRANCH=$OPTARG
    ;;
  c)
    BASE_COMPILER=$OPTARG
    ;;
  r)
    OMNI_REPO=$OPTARG
    ;;
  esac
done

# Try to load machine specific compiler information
COMPILER_FILE="${COMPUTER}.${BASE_COMPILER}.sh"
if [ -f $COMPILER_FILE ]
then
  source $COMPILER_FILE
else
  echo "Warning: Compiler file $COMPILER_FILE missing. Default values are used."
fi

echo ""
echo "OMNI Compiler information"
echo "========================="
echo " - Computer: $COMPUTER"
echo " - Repo: $OMNI_REPO"
echo " - Branch: $OMNI_BRANCH"
echo " - OMNI MPI CC: $OMNI_MPI_CC"
echo " - OMNI MPI FC: $OMNI_MPI_FC"
echo " - Base compiler: $BASE_COMPILER"
echo "  - FC : $OMNI_FC"
echo "  - CC : $OMNI_CC"
echo "  - CXX: $OMNI_CXX"
echo "========================="
echo ""

# Retrieve repository and branch
git clone -b $OMNI_BRANCH $OMNI_REPO omni-compiler
cd omni-compiler
FC=$OMNI_FC CC=$OMNI_CC CXX=$OMNI_CXX ./configure
make
