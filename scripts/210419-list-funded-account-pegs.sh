#!/bin/bash
## list-funded-account-pegs
## version 0.0.1 - initial
##################################################
list() {
  coinboy list:funded-account-amounts
}
get-value() {
  list | while read -r code rest
  do
   echo -e "${code}\t$( store get ${code,,}-${currency:-usd}-peg )"
  done | sort | deflate
}
_list-funded-account-pegs() { 
  interface "cached-${FUNCNAME//_/}"
}
##################################################
_list-funded-account-pegs ${@}
##################################################
## generated by create-stub2.sh v0.1.2
## on 
## see <https://github.com/temptemp3/sh2>
##################################################
