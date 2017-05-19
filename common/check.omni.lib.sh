#!/bin/bash

# Check if the .xmod file is well formatted and terminated
# arg1: .xmod file
function check_xmod_file {
  xmod_well_formatted=true
  if ! grep "<OmniFortranModule version=\"1.0\">" "$1" > /dev/null
  then
    xmod_well_formatted=false
  fi
  if ! grep "</OmniFortranModule>" "$1" > /dev/null
  then
    xmod_well_formatted=false
  fi
  echo "$xmod_well_formatted"
}
