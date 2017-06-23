#!/bin/bash

#
# This scripts helps to test the parsing of the full COSMO-POMPA
# code by the OMNI Compiler.
#

function show_help(){
  echo "$0 [-s] [-p] [--with-omni]"
  echo ""
  echo "Options:"
#  echo " -b <branch-name>  Specifiy the branch to be tested"
#  echo " -f                Use the forked repository for test"
#  echo " -c <compiler-id>  Define the base compiler to use"
#  echo " -i <install-path> Set an install path"
  echo " -s                Skip CLAW/OMNI compilation/install"
  echo " -p                Skip parsing step"
  echo " -o                Use the latest OMNI Compiler version for the test"
}

source ./common/check.omni.lib.sh
source ./common/utility.sh

# Working directories for the test
TEST_DIR=${PWD}/build
CLAW_OUTPUT="./processed/cosmo"
XMOD_DIR="./xmods/cosmo"

# CLAW repository variables
CLAW_BRANCH="master"
CLAW_MAIN_REPO="https://github.com/C2SM-RCM/claw-compiler.git"
CLAW_REPO=${CLAW_MAIN_REPO}
CLAWFC=./claw/bin/clawfc

# Default compiler used
BASE_COMPILER="gnu"

# Option switches
SKIP_CLAW=false
SKIP_PARSING=false
OMNI_LATEST=false

# COSMO related variables
COSMO_MAIN_REPO="git@github.com:MeteoSwiss-APN/cosmo-pompa.git"
COSMO_REP="cosmo-pompa"
COSMO_SRC="./${COSMO_REP}/cosmo/src/"
COSMO_START="lmorg.f90"
COSMO_DEP="dependencies_cosmo"


# Parsing output
PARSING_OUTPUT=${TEST_DIR}/cosmo_parse_test.log

while getopts "hfb:c:i:spo" opt; do
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
  o)
    OMNI_LATEST=true
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
fi

# Try to load machine specific compiler information
COMPILER_FILE="./compiler/${COMPUTER}.${BASE_COMPILER}.sh"
if [ -f $COMPILER_FILE ]
then
  # shellcheck source=./compiler/clementon2.gnu.sh
  source $COMPILER_FILE
else
  echo "Warning: Compiler file $COMPILER_FILE missing. Default values are used."
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

# Fetch the submodules
git submodule init
git submodule update

if [[ $SKIP_CLAW == false ]]
then
  # Specific CLAW/OMNI information
  echo "- CLAW Compiler information:"
  echo "  - Git repository: $CLAW_REPO"
  echo "  - Git branch: $CLAW_BRANCH"
  echo "  - Base compiler: $BASE_COMPILER"
  echo "  - Target directory: $TEST_DIR"

  rm -rf "$TEST_DIR"
  mkdir "$TEST_DIR"

  ###############################
  # 1. CLAW FORTRAN Compiler step
  ###############################

  echo ">>> CLAW FORTRAN COMPILER STEP: Clone and compile"
  if [[ $OMNI_LATEST == true ]]
  then
    ./common/compile.claw.sh -d "$TEST_DIR" -c "$BASE_COMPILER" -r "$CLAW_REPO" -b "$CLAW_BRANCH" -o
  else
    ./common/compile.claw.sh -d "$TEST_DIR" -c "$BASE_COMPILER" -r "$CLAW_REPO" -b "$CLAW_BRANCH"
  fi
else
  rm -rf "${TEST_DIR:?}"/${COSMO_REP}
fi

echo "============================================"
echo ""


cd "$TEST_DIR" || exit 1
WORKING_DIR="$PWD"

# Get git hashes for the log
echo "COSMO PARSING TESTS" > "${PARSING_OUTPUT}"
echo "-------------------" >> "${PARSING_OUTPUT}"
echo "Git version information:" >> "${PARSING_OUTPUT}"
cd claw-compiler || exit 1
CLAW_HASH=$(git rev-parse HEAD)
echo "- CLAW git version: $CLAW_HASH" >> "${PARSING_OUTPUT}"
cd omni-compiler || exit 1
OMNI_HASH=$(git rev-parse HEAD)
echo "- OMNI git version: $OMNI_HASH" >> "${PARSING_OUTPUT}"
cd "$WORKING_DIR" || exit 1


if [[ $SKIP_PARSING == false ]]
then


  #####################
  # 2. COSMO-POMPA step
  #####################

  git clone $COSMO_MAIN_REPO
  cd ${COSMO_REP} || exit 1
  COSMO_HASH=$(git rev-parse HEAD)
  echo "- COSMO-POMPA git version: $COSMO_HASH" >> "${PARSING_OUTPUT}"
  cd "$WORKING_DIR" || exit 1


  ####################
  # 3. Dependency step
  ####################

  # Generate the dependency list for the parsing order
  echo ">>> Generate dependencies list"
  ../fdependencies/generate_dep.py ${COSMO_SRC} ${COSMO_START} > ${COSMO_DEP} 2> dependencies_cosmo.out

  # Check existence of the dependencies file
  if [[ ! -f ${COSMO_DEP} ]]
  then
    echo "ERROR: ${COSMO_DEP} does not exists!"
    exit 1
  fi

  if [[ $(wc -l < ${COSMO_DEP}) -lt 2 ]]
  then
    echo "ERROR: ${COSMO_DEP} is empty!"
    exit 1
  fi


  #################
  # 4. Parsing step
  #################

  # Check existence of the CLAW FORTRAN Compiler
  if [[ ! -f ${CLAWFC} ]]
  then
    echo "ERROR: ${FRONT_END} does not exists!"
    exit 1
  fi

  mkdir -p ${XMOD_DIR}
  mkdir -p ${CLAW_OUTPUT}

  # Clean-up directories of potential previous run
  rm "${CLAW_OUTPUT}"/*.f90
  rm "${XMOD_DIR}"/*.xmod

  parsed_files=0
  echo ">>> Parsing files"
  echo "" >> "${PARSING_OUTPUT}"
  echo "Parsing files:" >> "${PARSING_OUTPUT}"
  while IFS= read -r f90_file
  do
    echo "    Processing file ${COSMO_SRC}${f90_file} -> ${CLAW_OUTPUT}/${f90_file}"
    echo "    Processing file ${COSMO_SRC}${f90_file} -> ${CLAW_OUTPUT}/${f90_file}" >> "${PARSING_OUTPUT}"
    mkdir -p "$(dirname "${CLAW_OUTPUT}"/"${f90_file}")"
    ${CLAWFC} --no-dep --debug-omni -J ${XMOD_DIR} --force -I "${INCLUDE_MPI}" -o "${CLAW_OUTPUT}"/"${f90_file}" "${COSMO_SRC}""${f90_file}" >> "${PARSING_OUTPUT}" 2>&1
    let parsed_files=parsed_files+1
    if [[ ! -f ${CLAW_OUTPUT}/${f90_file} ]]
    then
      print_red "[FAILED] ""${COSMO_SRC}""${f90_file}"
    fi
  done < ./${COSMO_DEP}
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
for xmod_file in ${XMOD_DIR}/*.xmod
do
  xmod_well_formatted=$(check_xmod_file "${xmod_file}")
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
while IFS= read -r f90_file
do
  if [[ ! -f ${CLAW_OUTPUT}/${f90_file} ]]
  then
    echo "ERROR: ${f90_file} has not been parsed correctly"
    let f90_errors=f90_errors+1
  fi
done < ./${COSMO_DEP}

# Report number of detected errors
if [[ ${f90_errors} -ne 0 ]]
then
  echo "------"
  echo "ERROR: ${f90_errors}/${parsed_files} .f90 files have not been parsed correctly"
fi


##############
# Report error
##############

# Check potential known errors in log file
error_type1=$(grep -c "only function/subroutine statement are allowed in contains top level" "${PARSING_OUTPUT}")
error_type2=$(grep -c "declaration among executables" "${PARSING_OUTPUT}")
error_type3=$(grep -c "syntax error" "${PARSING_OUTPUT}")
error_type4=$(grep -c "too many error, cannot recover from earlier errors: goodbye!" "${PARSING_OUTPUT}")
error_type5=$(grep -c "failed to import module" "${PARSING_OUTPUT}")

echo ""
echo "====================================="
echo "COSMO-POMPA full parsing test results"
echo "====================================="
if [[ ${xmod_errors} -ne 0 ]] || [[ ${f90_errors} -ne 0 ]] \
  || [[ ${error_type1} -ne 0 ]] || [[ ${error_type2} -ne 0 ]] \
  || [[ ${error_type3} -ne 0 ]] || [[ ${error_type4} -ne 0 ]] \
  || [[ ${error_type5} -ne 0 ]]
then
  echo "ERROR: Some errors have been detected"
  echo "       ${xmod_errors} errors with .xmod files"
  echo "       ${f90_errors} errors with .f90 files"
  echo "         ${error_type1} errors/warnings [only function/subroutine statement are allowed in contains top level] found in log"
  echo "         ${error_type2} errors/warnings [declaration among executables] found in log"
  echo "         ${error_type3} errors/warnings [syntax error] found in log"
  echo "         ${error_type4} errors/warnings [too many error, cannot recover from earlier errors: goodbye!] found in log"
  echo "         ${error_type5} errors/warnings [failed to import module] found in log"
  echo "       More information in the file: ${PARSING_OUTPUT}"
  echo "====================================="
  exit 1
else
  echo "SUCCESS: Test has be executed correctly."
  echo "====================================="
  exit 0
fi
