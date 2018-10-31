#!/bin/bash

# function omni::applyFix {
#   omni_directory=$1
#
#   cd "${omni_directory}" || exit 1
#   git checkout master
#   git checkout -b fixed
#   git remote add fix git@github.com:clementval/xcodeml-tools.git
#   git fetch fix
#   git merge -n --commit issue12
#   git merge -n --commit issue14
# }

# Check if the .xmod file is well formatted and terminated
# $1: .xmod file
function omni::check_xmod_file {
  local xmod_well_formatted=true
  if ! grep "<OmniFortranModule version=\"1.0\">" "$1" > /dev/null; then
    xmod_well_formatted=false
  fi
  if ! grep "</OmniFortranModule>" "$1" > /dev/null; then
    xmod_well_formatted=false
  fi
  echo "$xmod_well_formatted"
}

# Check correctness of xmod files
# $1: Directory where xmod files are located
# $2: Result variable
function omni::check_xmod {
  echo ""
  echo "-----------------------"
  echo ">>> Control .xmod files"
  echo "-----------------------"

  local __xmods_dir=$1
  local __resultvar=$2
  local __errors=0
  for xmod_file in "${__xmods_dir}"/*.xmod; do
    xmod_well_formatted=$(omni::check_xmod_file "${xmod_file}")
    if [[ ${xmod_well_formatted} == false ]]; then
      echo "ERROR: ${xmod_file} file is not formatted correctly"
      (( __errors=__errors+1 ))
    fi
  done

  if [[ ${__errors} -ne 0 ]]; then
    print_red "> ERROR: ${__errors} .xmod files didn't pass the check"
  else
    print_green "> XMOD check succeed"
  fi

  # shellcheck disable=SC2086
  eval $__resultvar="'$__errors'"
}

# Check correctness of fortran files
# $1: File list to control
# $2: Directory where fortran files are located
# $3: Result variable
function omni::check_fortran {
  echo ""
  echo "----------------------"
  echo ">>> Control .f90 files"
  echo "----------------------"
  # Control if target file has been produced

  local __file_list=$1
  local __fortran_dir=$2
  local __resultvar=$3
  local __errors=0
  while IFS= read -r f90_file; do
    if [[ ! -f ${__fortran_dir}/${f90_file} ]]; then
      echo "ERROR: ${f90_file} has not been parsed correctly"
      (( __errors=__errors+1 ))
    fi
  done < ./"${__file_list}"

  # Report number of detected errors
  if [[ ${__errors} -ne 0 ]]; then
    print_red "> ERROR: ${__errors} .f90 files have not been parsed correctly"
  else
    print_green "> Fortran check succeed"
  fi

  # shellcheck disable=SC2086
  eval $__resultvar="'$__errors'"
}


# Check potential known errors in log file
# $1: Path to the log file
function omni::check_error_log {
  local __parse_log="$1"

  local error_type1
  local error_type2
  local error_type3
  local error_type4
  local error_type5
  local error_type6
  local error_type7
  local error_type8
  local error_type9
  local error_type10
  local error_type11
  local error_type12
  local error_type13
  local error_type14
  local error_type15
  local error_type16
  local error_type17
  local error_type18
  local error_type19
  local error_type20

  error_type1=$(grep -c "only function/subroutine statement are allowed in contains top level" "${__parse_log}")
  error_type2=$(grep -c "declaration among executables" "${__parse_log}")
  error_type3=$(grep -c "syntax error" "${__parse_log}")
  error_type4=$(grep -c "too many error, cannot recover from earlier errors: goodbye!" "${__parse_log}")
  error_type5=$(grep -c "failed to import module" "${__parse_log}")
  error_type6=$(grep -c "incompatible dimension for the operation" "${__parse_log}")
  error_type7=$(grep -c "argument(s) mismatch for an intrinsic" "${__parse_log}")
  error_type8=$(grep -c "java.lang.OutOfMemoryError" "${__parse_log}")
  error_type9=$(grep -c "compiler error: type attr error" "${__parse_log}")
  error_type10=$(grep -c "is not found for" "${__parse_log}")
  error_type11=$(grep -c "invalid left operand of" "${__parse_log}")
  error_type12=$(grep -c "attempt to use undefined type variable" "${__parse_log}")
  error_type13=$(grep -c "bad char" "${__parse_log}")
  error_type14=$(grep -c "Unable to decompile XcodeML to Fortran" "${__parse_log}")
  error_type15=$(grep -c "bad expression in constant kind parameter" "${__parse_log}")
  error_type16=$(grep -c "is not a subroutine" "${__parse_log}")
  error_type17=$(grep -c "Derived-type mismatch" "${__parse_log}")
  error_type18=$(grep -c "right hand side expression is not a pointee" "${__parse_log}")
  error_type19=$(grep -c "can't determine type of constant expression" "${__parse_log}")
  error_type20=$(grep -c "compiler error" "${PARSING_OUTPUT}")
  error_type21=$(grep -c "is not found in module" "${PARSING_OUTPUT}")
  error_type22=$(grep -c "Segmentation fault" "${PARSING_OUTPUT}")

  if [[ ${error_type1} -ne 0 ]] || [[ ${error_type2} -ne 0 ]]   \
    || [[ ${error_type3} -ne 0 ]] || [[ ${error_type4} -ne 0 ]]   \
    || [[ ${error_type5} -ne 0 ]] || [[ ${error_type6} -ne 0 ]]   \
    || [[ ${error_type7} -ne 0 ]] || [[ ${error_type8} -ne 0 ]]   \
    || [[ ${error_type9} -ne 0 ]] || [[ ${error_type10} -ne 0 ]]  \
    || [[ ${error_type11} -ne 0 ]] || [[ ${error_type12} -ne 0 ]] \
    || [[ ${error_type13} -ne 0 ]] || [[ ${error_type14} -ne 0 ]] \
    || [[ ${error_type15} -ne 0 ]] || [[ ${error_type16} -ne 0 ]] \
    || [[ ${error_type17} -ne 0 ]] || [[ ${error_type18} -ne 0 ]] \
    || [[ ${error_type19} -ne 0 ]] || [[ ${error_type20} -ne 0 ]] \
    || [[ ${error_type21} -ne 0 ]] || [[ ${error_type22} -ne 0 ]]; then
    echo "ERROR: Some errors have been detected"
    echo "         ${error_type1} errors/warnings [only function/subroutine statement are allowed in contains top level] found in log"
    echo "         ${error_type2} errors/warnings [declaration among executables] found in log"
    echo "         ${error_type3} errors/warnings [syntax error] found in log"
    echo "         ${error_type4} errors/warnings [too many error, cannot recover from earlier errors: goodbye!] found in log"
    echo "         ${error_type5} errors/warnings [failed to import module] found in log"
    echo "         ${error_type6} errors/warnings [incompatible dimension for the operation] found in log"
    echo "         ${error_type7} errors/warnings [argument(s) mismatch for an intrinsic] found in log"
    echo "         ${error_type8} errors/warnings [java.lang.OutOfMemoryError] found in log"
    echo "         ${error_type9} errors/warnings [compiler error: type attr error] found in log"
    echo "         ${error_type10} errors/warnings [X if not found for end X] found in log"
    echo "         ${error_type11} errors/warnings [invalid left operand of] found in log"
    echo "         ${error_type12} errors/warnings [attempt to use undefined type variable] found in log"
    echo "         ${error_type13} errors/warnings [bad char] found in log"
    echo "         ${error_type14} errors/warnings [Unable to decompile XcodeML to Fortran] found in log"
    echo "         ${error_type15} errors/warnings [bad expression in constant kind parameter] found in log"
    echo "         ${error_type16} errors/warnings [is not a subroutine] found in log"
    echo "         ${error_type17} errors/warnings [Derived-type mismatch] found in log"
    echo "         ${error_type18} errors/warnings [right hand side expression is not a pointee] found in log"
    echo "         ${error_type19} errors/warnings [can't determine type of constant expression] found in log"
    echo "         ${error_type20} errors/warnings [compiler error] found in log"
    echo "         ${error_type21} errors/warnings [is not found in module] found in log"
    echo "         ${error_type22} errors/warnings [Segmentation fault] found in log"
    echo "       More information in the file: ${__parse_log}"
    echo "====================================="
  fi
}
