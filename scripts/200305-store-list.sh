#!/bin/bash
## store-list
## version 0.0.3 - use store list
##################################################
# shellcheck disable=SC1091
 . "${SH2}/store.sh"
_store-list() { 
  init-store-silent
  store list
}
##################################################
_store-list
##################################################
## generated by create-stub2.sh v0.1.2
## on Thu, 05 Mar 2020 21:33:08 +0900
## see <https://github.com/temptemp3/sh2>
##################################################
