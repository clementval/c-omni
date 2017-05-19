#!/bin/bash

#
# This scripts to compile CLAW FORTRAN Compiler for the parsing tests.
#

function show_help(){
  echo "$0 [-r <repository-url>] [-b <branch-name>] [-c gnu|pgi|cray] [-d <target-directory>]"
  echo ""
  echo "Options:"
  echo " -r <repository-url>   Specify the URL of the GIT repository"
  echo " -b <branch-name>      Specify the branch to be tested"
  echo " -c <compiler-id>      Define the base compiler to use"
  echo " -d <target-directory> Specify target directory for the clone and compilation"
}

# Define default local variable
CLAW_BRANCH="master"
CLAW_REPO="https://github.com/C2SM-RCM/claw-compiler.git"
BASE_COMPILER="gnu"
OMNI_FC="gfortran"
OMNI_CC="gcc"
OMNI_CXX="g++"
OMNI_MPI_CC="MPI_CC=mpicc"
OMNI_MPI_FC="MPI_FC=mpif90"

COMPUTER=$(hostname)
if [[ $COMPUTER == daint* ]]
then
  COMPUTER="daint"
elif [[ $COMPUTER == kesch* ]]
then
  COMPUTER="kesch"
  module load cmake
  module load PrgEnv-gnu
fi

TARGET_DIRECTORY=${PWD}/build

while getopts "hb:c:r:d:" opt; do
  case "$opt" in
  h)
    show_help
    exit 0
    ;;
  b)
    CLAW_BRANCH=$OPTARG
    ;;
  c)
    BASE_COMPILER=$OPTARG
    ;;
  r)
    CLAW_REPO=$OPTARG
    ;;
  d)
    TARGET_DIRECTORY=$OPTARG
    ;;
  esac
done

# Try to load machine specific compiler information
COMPILER_FILE="./compiler/${COMPUTER}.${BASE_COMPILER}.sh"
if [ -f $COMPILER_FILE ]
then
  # shellcheck source=$COMPILER_FILE
  source $COMPILER_FILE
else
  echo "Warning: Compiler file $COMPILER_FILE missing. Default values are used."
fi

echo ""
echo "================================="
echo "CLAW FORTRAN Compiler information"
echo "================================="
echo " - Computer: $COMPUTER"
echo " - Repo: $CLAW_REPO"
echo " - Branch: $CLAW_BRANCH"
echo " - OMNI MPI CC: $OMNI_MPI_CC"
echo " - OMNI MPI FC: $OMNI_MPI_FC"
echo " - OMNI ADDITIONAL CONFIG: $OMNI_CONF"
echo " - Base compiler: $BASE_COMPILER"
echo "  - FC : $OMNI_FC"
echo "  - CC : $OMNI_CC"
echo "  - CXX: $OMNI_CXX"
echo " - Target directory: $TARGET_DIRECTORY"
echo "================================="
echo ""

# Create target directory
mkdir -p $TARGET_DIRECTORY
rm -rf $TARGET_DIRECTORY/claw-compiler

# Retrieve repository and branch
cd $TARGET_DIRECTORY || exit 1
git clone -b $CLAW_BRANCH $CLAW_REPO claw-compiler
cd claw-compiler || exit 1

# Get submodules
git submodule init
git submodule update

# Configure CLAW repo
echo "FC=$OMNI_FC CC=$OMNI_CC CXX=$OMNI_CXX cmake -DCMAKE_INSTALL_PREFIX=$TARGET_DIRECTORY/claw -DOMNI_MPI_CC=$OMNI_MPI_CC -DOMNI_MPI_FC=$OMNI_MPI_FC ."
FC=$OMNI_FC CC=$OMNI_CC CXX=$OMNI_CXX cmake -DCMAKE_INSTALL_PREFIX=$TARGET_DIRECTORY/claw -DOMNI_MPI_CC=$OMNI_MPI_CC -DOMNI_MPI_FC=$OMNI_MPI_FC .

# Compile CLAW and OMNI
make
make install

cd - || exit 1
