#!/bin/bash
## clipboy-make
## version 0.0.2 - source create-stub2
##################################################
create-stub2() { ${SH2}/${FUNCNAME}.sh ${@} ; }
clipboy-make-command() { { local function_name ; function_name="${1}" ; }
  test "${function_name}" || {
    clipboy-say "What command Me makes?" 
    read candidate_command
    function_name=${candidate_command}
  }
  test ! "${function_name}" || {
    test -f "$( dirname ${0} )/${function_name}.sh" || {
      clipboy-say "Me makes ${function_name} command"
      {
        {
          create-stub-generate-stub-head() { 
	    cat << EOF
#!/bin/bash
## ${program}
## version 0.0.1 - initial
EOF
          }
	  create-stub-generate-stub-entry() {
            cat << EOF
##################################################
command-name-third-person-present() {
  echo "\${command_name}s"
}
clipboy-${program}-default() {
  clipboy-say "Me \$( command-name-third-person-present )"
}
clipboy-${program}-help() { 
  clipboy-${program}() {
    commands
  }
  unset -f clipboy-\${command_name}-help
  unset -f clipboy-\${command_name}-default
  clipboy-\${command_name}
}
clipboy-${program}() { { local command_type ; command_type="\$( echo \${1} | cut '-d:' '-f2' )" ; }
 local command_name
  command_name="${program}"
  case "\$( declare -f \${FUNCNAME}-\${command_type} )" in
   "") {
     \${FUNCNAME}-default
   } ;;
   *) {
     \${FUNCNAME}-\${command_type} \${@:2}
   } ;;
  esac
}
##################################################
## generated by $( basename ${0} ) v$( grep -e 'version' ${0} | head -n  1 | cut '-f3' '-d ' )
## on $( date --rfc-2822 )
## see <https://github.com/temptemp3/sh2>
##################################################
EOF
          }
	  declare -xf create-stub-generate-stub-head
	  declare -xf create-stub-generate-stub-entry
          create-stub2 ${function_name} 
        } | tee $( dirname ${0} )/commands/$( date +%y%m%d )-clipboy-${function_name}.sh
      } &>/dev/null
    }
  }
}
clipboy-make-function() { { local function_name ; function_name="${1}" ; }
  if-dated() {
    test ! "${dated}" = "true" || echo "$( date +%y%m%d )-"
  }
  if-single() {
    test "${single}" = "true"
  }
  path-to-script() {
    if-single && {
      echo $( if-dated )${function_name}.sh
    true
    } || {
      echo ${function_name}.sh/$( if-dated )${function_name}.sh
    }
  }
  local dated
  local single
  for arg in ${@}
  do
   case ${arg} in
   --dated) dated="true" ;;
   --single) single="true" ;;
   *) true ;;
   esac
  done
  test !  "${function_name}" && return
  test "${single}" = "true" || {
    test -d "${function_name}.sh" && return
    test -f "${function_name}.sh/${function_name}.sh" && return
    mkdir -pv "${function_name}.sh" 
  }
  clipboy-say "Me makes functions" 
  {
    create-stub-generate-stub-head() { 
      cat << EOF
#!/bin/bash
## ${program}
## version 0.0.1 - initial
EOF
    }
    declare -xf create-stub-generate-stub-head
    create-stub2 ${function_name} \
    | tee $( path-to-script )
  }
}
clipboy-make-default() { 
  clipboy-say "Me makes lemonade"
}
clipboy-make-help() {
  clipboy-make() {
    commands
  }
  unset -f clipboy-make-help
  unset -f clipboy-make-default
  clipboy-make
}
clipboy-make() { 
  { local command_type ; command_type="$( echo ${1} | cut '-d:' '-f2' )" ; }
  case "$( declare -f ${FUNCNAME}-${command_type} )" in
   "") {
     ${FUNCNAME}-default
   } ;;
   *) {
     ${FUNCNAME}-${command_type} ${@:2}
   } ;;
  esac
}
##################################################
## generated by create-stub2.sh v0.1.1
## on Mon, 14 Jan 2019 12:45:14 +0900
## see <https://github.com/temptemp3/sh2>
##################################################
