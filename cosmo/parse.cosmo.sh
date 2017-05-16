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
  echo " -p                Skip parsing step"
}

# Define local variable
CLAW_BRANCH="master"
CLAW_MAIN_REPO="https://github.com/C2SM-RCM/claw-compiler.git"
#CLAW_FORK_REPO="https://github.com/MeteoSwiss-APN/omni-compiler.git"
CLAW_REPO=$CLAW_MAIN_REPO

COSMO_MAIN_REPO="git@github.com:MeteoSwiss-APN/cosmo-pompa.git"

TEST_DIR=./build
INSTALL_DIR=$TEST_DIR/install
BASE_COMPILER="gnu"

SKIP_CLAW=false
SKIP_PARSING=false

CLAWFC=./claw/bin/clawfc
CLAW_OUTPUT="./processed"

COSMO_SRC="./cosmo-pompa/cosmo/src/"
COSMO_START="lmorg.f90"
COSMO_DEP="dependencies_cosmo"

while getopts "hfb:c:i:sp" opt; do
  case "$opt" in
  h)
    show_help
    exit 0
    ;;
  s)
    SKIP_CLAW=true
    ;;
  p)
    SKIP_PARSING=true
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
if [[ $COMPUTER == *"kesch"* ]]
then
  COMPUTER="kesch"
  module load cmake
  module load GCC
fi
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

if [[ $SKIP_CLAW == false ]]
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


  ###############################
  # 1. CLAW FORTRAN Compiler step
  ###############################

  echo ">>> CLAW COMPILER STEP: Clone and compile"
  ./common/compile.claw.sh -d $TEST_DIR -c $BASE_COMPILER -r $CLAW_REPO -b $CLAW_BRANCH

else
  rm -rf $TEST_DIR/cosmo-pompa
fi

echo "============================================"
echo ""

cd $TEST_DIR

if [[ $SKIP_PARSING == false ]]
then

  #####################
  # 2. COSMO-POMPA step
  #####################

  git clone $COSMO_MAIN_REPO


  ####################
  # 3. Dependency step
  ####################

  # Generate the dependency list for the parsing order
  echo ">>> Generate dependencies list"
  ../fdependencies/generate_dep.py ${COSMO_SRC} ${COSMO_START} > ${COSMO_DEP} 2> dependencies.out


  #################
  # 4. Parsing step
  #################

  mkdir -p xmods
  mkdir -p $CLAW_OUTPUT

  echo ">>> Pasring files"
  for FILE in $(cat ./${COSMO_DEP})
  do
    echo "    Processing file ${COSMO_SRC}${FILE} -> ${CLAW_OUTPUT}/${FILE}"
    ${CLAWFC} -J xmods --force -o ${CLAW_OUTPUT}/${FILE} ${COSMO_SRC}${FILE}
  done
fi


#################
# 5. Control step
#################

echo ""
echo "-----------------------"
echo ">>> Control .xmod files"
echo "-----------------------"
# Control if present .xmod file has been produced correctly
xmod_errors=0
for xmod_file in $(ls xmods/*.xmod)
do
  xmod_well_formatted=true
  cat ${xmod_file} | grep "<OmniFortranModule version=\"1.0\">" > /dev/null
  [[ $? -ne 0 ]] && xmod_well_formatted=false
  cat ${xmod_file} | grep "</OmniFortranModule>" > /dev/null
  [[ $? -ne 0 ]] && xmod_well_formatted=false

  if [[ $xmod_well_formatted == false ]]
  then
    echo "ERROR: ${xmod_file} file is not formatted correctly"
    let xmod_errors=xmod_errors+1
  fi
done

# Report number of detected errors
if [[ ${xmod_errors} -ne 0 ]]
then
  echo "------"
  echo "ERROR: ${xmod_errors} .xmod files didn't pass the check"
fi


echo ""
echo "----------------------"
echo ">>> Control .f90 files"
echo "----------------------"
# Control if target file has been produced
f90_errors=0
for f90_file in $(cat ./${COSMO_DEP})
do
  if [[ ! -f ${CLAW_OUTPUT}/${f90_file} ]]
  then
    echo "ERROR: ${f90_file} has not been parsed correctly"
    let f90_errors=f90_errors+1
  fi
done

# Report number of detected errors
if [[ ${f90_errors} -ne 0 ]]
then
  echo "------"
  echo "ERROR: ${f90_errors} .f90 files have not been parsed correctly"
fi


##############
# Report error
##############

echo ""
echo "====================================="
echo "COSMO-POMPA full parsing test results"
echo "====================================="
if [[ ${xmod_errors} -ne 0 ]] || [[ ${f90_errors} -ne 0 ]]
then
  echo "ERROR: Some errors have been detected"
  echo "       ${xmod_errors} errors with .xmod files"
  echo "       ${f90_errors} errors with .f90 files"
else
  echo "SUCCESS: Test has be executed correctly."
fi
echo "====================================="
