#! /bin/bash

# Command
COMMAND=$(basename ${0})
# SubCommand
SUB_COMMAND=${1}
shift

# Default
CURRENT_BRANCH_NAME=$(git branch | sed -n '/\* /s///p')
OUTPUT="./patch/"$(date +%Y%m%d)"/"${CURRENT_BRANCH_NAME}

function usage {
    cat <<EOF

Usage:
    ${COMMAND} [command] [<options>]

Command:
    exec              diff patch
    help              help

Options:
    --branch -b       branch name
    --output -o       output directory
EOF
}

function exec {
  FILE_NAME=`date "+%Y%m%d-%H%M%S"`"_"$CURRENT_BRANCH_NAME"_diff.patch"
  DIFF=""

  echo $CURRENT_BRANCH_NAME
  echo $FILE_NAME
  if [ ! -e $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
  fi
   
  git diff --no-prefix $DIFF > $OUTPUT_DIR"/"$FILE_NAME
}


# OPTION
while [ $# -gt 0 ];
do
  case ${1} in
    --branch|-b)
      CURRENT_BRANCH_NAME=${2}
      shift
      ;;
    --output|-o)
      OUTPUT=${2}
      shift
      ;;
done

# COMMAND
case ${1} in
    help)
      usage
      shift
      ;;
    exec)
      exec
      shift
      ;;
    *)
      echo "[ERROR] ${COMMAND} ${SUB_COMMAND}"
      usage
      exit 1
      ;;
esac
