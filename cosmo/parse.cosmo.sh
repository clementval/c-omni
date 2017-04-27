#!/bin/bash

#
# This scripts helps to test the parsing of the full COSMO-POMPA
# code by the OMNI Compiler.
#

function show_help(){
  echo "$0 [-b <branch-name>] [-f] [-c gnu|pgi|cray] [-i <install-path>]"
  echo ""
  echo "Options:"
  echo " -b <branch-name>  Specifiy the branch to be tested"
  echo " -f                Use the forked repository for test"
  echo " -c <compiler-id>  Define the base compiler to use"
  echo " -i <install-path> Set an install path"
}

# Define local variable
OMNI_BRANCH="master"
OMNI_MAIN_REPO="https://github.com/omni-compiler/omni-compiler.git"
OMNI_FORK_REPO="https://github.com/MeteoSwiss-APN/omni-compiler.git"
OMNI_REPO=$OMNI_MAIN_REPO

COSMO_MAIN_REPO="git@github.com:MeteoSwiss-APN/cosmo-pompa.git"

TEST_DIR=buildtemp-omni
INSTALL_DIR=$PWD/$TEST_DIR/install
BASE_COMPILER="gnu"

while getopts "hfb:c:i:" opt; do
  case "$opt" in
  h)
    show_help
    exit 0
    ;;
#  f)
#    CLAW_REPO=$CLAW_FORK_REPO
#    ;;
#  b)
#    CLAW_BRANCH=$OPTARG
#    ;;
#  c)
#    CLAW_BASE_COMPILER=$OPTARG
#    ;;
#  i)
#    CLAW_INSTALL_DIR=$OPTARG
#    ;;
  esac
done

COMPUTER=$(hostname)

#if [[ $COMPUTER == *"daint"* ]]
#then
#  COMPUTER="daint"
#  CMAKE_MOD="CMake"
#elif [[ $COMPUTER == *"kesch"* ]]
#then
#  COMPUTER="kesch"
#  CMAKE_MOD="cmake"
#fi
#
#
#
## Load recent version of cmake
#module load $CMAKE_MOD
#
## Load correct PrgEnv
#case  "$CLAW_BASE_COMPILER" in
#  "gnu")
#    module rm PrgEnv-pgi && module rm PrgEnv-cray
#    module load PrgEnv-gnu
#    if [[ $COMPUTER == "kesch" ]]
#    then
#      CLAW_FC=gfortran
#      CLAW_CC=gcc
#      CLAW_CXX=g++
#    elif [[ $COMPUTER == "daint" ]]
#    then
#      CLAW_FC=ftn
#      CLAW_CC=cc
#      CLAW_CXX=CC
#      OMNI_MPI_CC="MPI_CC=cc"
#      OMNI_MPI_FC="MPI_FC=ftn"
#      ADDITONAL_OPTIONS="-DOMNI_MPI_CC=$OMNI_MPI_CC -DOMNI_MPI_FC=$OMNI_MPI_FC"
#    fi
#  ;;
#  "pgi")
#    module rm PrgEnv-gnu && module rm PrgEnv-cray
#    module load PrgEnv-pgi
#    if [[ $COMPUTER == "kesch" ]]
#    then
#      CLAW_FC=mpif90
#      CLAW_CC=mpicc
#      CLAW_CXX=pgc++
#    elif [[ $COMPUTER == "daint" ]]
#    then
#      module load gcc
#      CLAW_FC=ftn
#      CLAW_CC=cc
#      CLAW_CXX=CC
#      OMNI_MPI_CC="MPI_CC=cc"
#      OMNI_MPI_FC="MPI_FC=ftn"
#      ADDITONAL_OPTIONS="-DOMNI_MPI_CC=$OMNI_MPI_CC -DOMNI_MPI_FC=$OMNI_MPI_FC"
#    fi
#  ;;
#  "cray")
#    module rm PrgEnv-pgi && module rm PrgEnv-gnu
#    module load PrgEnv-cray
#    CLAW_FC=ftn
#    CLAW_CC=cc
#    CLAW_CXX=CC
#  ;;
#  *)
#    echo "Error: Unknown compiler ..."
#    exit 1
#esac

echo ""
echo "======================================="
echo "COSMO-POMPA -> OMNI Compiler parse test"
echo "======================================="
echo "- COMSO information: $COSMO_MAIN_REPO"
echo "  - Git repository: $COSMO_MAIN_REPO"
echo "- OMNI Compiler information:"
echo "  - Git repository: $OMNI_REPO"
echo "  - Git branch: $OMNI_BRANCH"
echo "  - Base compiler: $BASE_COMPILER"
echo "  - Target directory: $TEST_DIR"
echo "- Install path: $CLAW_INSTALL_DIR"
echo "- Dest dir: $CLAW_TEST_DIR"
echo "======================================="
echo ""


# Prepare directory
rm -rf $TEST_DIR
mkdir $TEST_DIR

# OMNI Compiler
echo ">>> OMNI COMPILER STEP: Clone and compile"
./compile.omni.sh -d $TEST_DIR -c $BASE_COMPILER -r $OMNI_REPO -b $OMNI_BRANCH

# Fetch COSMO
cd $TEST_DIR
git clone $COSMO_MAIN_REPO


# Parsing test
F_FRONT=./omni-compiler/F-FrontEnd/src/F_Front
COSMO_SRC="./cosmo-pompa/cosmo/src/"
mkdir -p xmods


for FILE in "mo_kind.f90"
do
  ${F_FRONT} -M xmods -o ${FILE}.xml ${COSMO_SRC}${FILE}
done
