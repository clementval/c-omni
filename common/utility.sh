#!/bin/bash

function print_red {
  echo -e "\\033[91m$1\\033[0m"
}

function print_green {
  echo -e "\\033[32m$1\\033[0m"
}

function print_orange {
  echo -e "\\033[33m$1\\033[0m"
}

function error {
  print_red "[ERROR] $1"
}

function status {
  print_green "[STATUS] $1"
}

function warning {
  print_orange "[WARNING] $1"
}
