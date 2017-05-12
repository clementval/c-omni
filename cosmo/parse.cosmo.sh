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
  echo " -s                Skip CLAW/OMNI compilation/install"
}

# Define local variable
CLAW_BRANCH="master"
CLAW_MAIN_REPO="https://github.com/C2SM-RCM/claw-compiler.git"
#CLAW_FORK_REPO="https://github.com/MeteoSwiss-APN/omni-compiler.git"
CLAW_REPO=$CLAW_MAIN_REPO

COSMO_MAIN_REPO="git@github.com:MeteoSwiss-APN/cosmo-pompa.git"

TEST_DIR=$(PWD)/build
INSTALL_DIR=$PWD/$TEST_DIR/install
BASE_COMPILER="gnu"

SKIP=false

while getopts "hfb:c:i:s" opt; do
  case "$opt" in
  h)
    show_help
    exit 0
    ;;
  s)
    SKIP=true
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
echo "============================================"
echo "COSMO-POMPA -> CLAW/OMNI Compiler parse test"
echo "============================================"
echo "- COMSO information"
echo "  - Git repository: $COSMO_MAIN_REPO"

if [[ $SKIP == false ]]
then
  # Specific CLAW/OMNI information
  echo "- CLAW/OMNI Compiler information:"
  echo "  - Git repository: $CLAW_REPO"
  echo "  - Git branch: $CLAW_BRANCH"
  echo "  - Base compiler: $BASE_COMPILER"
  echo "  - Target directory: $TEST_DIR"
  echo "- Install path: $CLAW_INSTALL_DIR"
  echo "- Dest dir: $CLAW_TEST_DIR"

  rm -rf $TEST_DIR
  mkdir $TEST_DIR
  # OMNI Compiler
  echo ">>> CLAW COMPILER STEP: Clone and compile"
  ./common/compile.claw.sh -d $TEST_DIR -c $BASE_COMPILER -r $CLAW_REPO -b $CLAW_BRANCH
else
  rm -rf $TEST_DIR/cosmo-pompa
fi

echo "============================================"
echo ""

# Fetch COSMO
cd $TEST_DIR
git clone $COSMO_MAIN_REPO

# Parsing test
CLAWFC=./claw/bin/clawfc
COSMO_SRC="./cosmo-pompa/cosmo/src/"
CLAW_OUTPUT="./processed"
mkdir -p xmods
mkdir -p $CLAW_OUTPUT



echo ">>> Parsing steps"
# TODO gather file list from dependency resolver
for FILE in "mo_kind.f90"
do
  echo "Processing file ${COSMO_SRC}${FILE} -> ${CLAW_OUTPUT}/${FILE}"
  ${CLAWFC} -J xmods --force -o ${CLAW_OUTPUT}/${FILE} ${COSMO_SRC}${FILE}
done
