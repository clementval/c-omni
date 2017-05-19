#!/bin/bash

shellcheck common/check.omni.lib.sh
shellcheck common/compile.claw.sh compiler/clementon2.gnu.sh
shellcheck common/compile.omni.sh compiler/clementon2.gnu.sh
shellcheck cosmo/parse.cosmo.sh compiler/clementon2.gnu.sh common/check.omni.lib.sh
