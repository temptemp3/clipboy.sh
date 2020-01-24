#!/bin/bash
## clipboy
## - reads from clipboard and does things
## version 0.1.1 - fix entry
##################################################
. ${SH2}/error.sh		# error handling
error "true"			# show errors
. ${SH2}/cecho.sh		# colored echo
. ${SH2}/aliases/commands.sh	# commands
##################################################
generate-temp() { ${SH2}/generate-temp.sh ${@} ; }
##################################################
_cleanup() {
  {
    cecho yellow $( rm -rvf ${temp}-* )
  } 2>/dev/null
}
##################################################
temp= 
initialize() {
 temp=$( 
  generate-temp 
 )
 touch "${temp}-test"
}
##################################################
clipboy-say() {
 cecho green "${@}"
}
##################################################
clipboy-stretch() {
 clipboy-say $( clipboy-dialog stretch )
 touch "${temp}-clipboard"
 sleep 3
 clipboy-say "Me's stetchy!"
}
##################################################
clipboy-run() {
 clipboy-say $( clipboy-dialog hi )
 clipboy-stretch
 sleep 2
 while [ ! ]
 do
  clipboy-eat
  clipboy-think
  clipboy-act
  ################################################
  ## =notes=
  ## (1) block may depend on runtime mode later
  ################################################
  [ ! ] && {
   echo press enter key to continue
   read
  true
  } || {
   break
  }
  ################################################
  clipboy-sleep
 done
 clipboy-say $( clipboy-dialog bye )
}
##################################################
clipboy-eat() {
  clipboy-say $( clipboy-dialog hungry )
  {
    cat /dev/clipboard > ${temp}-infile
  } 1>/dev/null
  clipboy-say $( clipboy-dialog delicious )
}
##################################################
clipboy-think() {
  clipboy-say $( clipboy-dialog thinking )
  ################################################
  ## =todo=
  ## + add some decision making here
  ################################################
  {
    {
      diff ${temp}-{clipboard,infile} || true
    } #| head -n 3 
  } #1>/dev/null
  ################################################
}
##################################################
clipboy-sleep() {
 clipboy-say $( clipboy-dialog sleepy )
 sleep 5
}
##################################################
clipboy-dialog() {
 . $( dirname ${0} )/${FUNCNAME}.sh
 test ! -f "$( dirname ${0} )/${FUNCNAME}-custom.sh" || {
  . $( dirname ${0} )/${FUNCNAME}-custom.sh
 }
 commands
}
##################################################
clipboy-act() {
 . $( dirname ${0} )/${FUNCNAME}.sh
 test ! -f "$( dirname ${0} )/${FUNCNAME}-custom.sh" || {
  . $( dirname ${0} )/${FUNCNAME}-custom.sh
 }
 ${FUNCNAME}
}
##################################################
clipboy-main() { 
  list-available-commands clipboy-
}
clipboy() { { local candidate_command ; candidate_command="$( echo ${1} | cut '-d:' '-f1' )" ; }
 initialize
 test -d "$( dirname ${0} )/commands" || mkdir -pv "${_}"
 local command_found
 for command_found in $( find $( dirname ${0} )/commands -type f -name "*-clipboy-${candidate_command}*.sh" )
 do
  cecho green importing $( basename ${command_found} .sh ) ...
  . ${command_found}
 done 2>/dev/null
 test ! "$( declare -f clipboy-${candidate_command} )" || {
   clipboy-${candidate_command} ${@}
   # history here
   return
 }
 commands
}
##################################################
if [ ! ] 
then
 true
else
 exit 1 # wrong args
fi
##################################################
clipboy ${@}
##################################################
## generated by create-stub2.sh v0.1.1
## on Thu, 08 Nov 2018 12:51:06 +0900
## see <https://github.com/temptemp3/sh2>
##################################################
