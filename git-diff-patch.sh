#! /bin/bash

function usage {
    cat <<EOF

Usage:
    $(basename ${0}) [command] [<options>]

Command:
    exec              diff patch
    help              help

Options:
    --help, -h        help

EOF
}

function exec {
  CURRENT_BRANCH_NAME=`git branch | sed -n '/\* /s///p'`
  FILE_NAME=`date "+%Y%m%d-%H%M%S"`"_"$CURRENT_BRANCH_NAME"_diff.patch"
  DIR_NAME=`date "+%Y%m%d"`
  OUTPUT_DIR="./patch/"$DIR_NAME"/"$CURRENT_BRANCH_NAME
  DIFF=""

  echo $CURRENT_BRANCH_NAME
  echo $FILE_NAME
  if [ ! -e $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
  fi
   
  git diff --no-prefix $DIFF > $OUTPUT_DIR"/"$FILE_NAME
}

while [ $# -gt 0 ];
do
    case ${1} in

        help|--help|-h)
          usage
          shift
          ;;

        exec)
          exec
          shift
          ;;

        *)
          echo "ERROR] ${1}"
          usage
          exit 1
          ;;
    esac
    shift
done
