#! /bin/bash

# Command
COMMAND=$(basename ${0})
# SubCommand
SUB_COMMAND=${1}
shift

# Default
CURRENT_BRANCH_NAME=$(git branch | sed -n '/\* /s///p')
OUTPUT="./patch/"$(date +%Y%m%d)"/"${CURRENT_BRANCH_NAME}
FILE_NAME=$(date +%Y%m%d-%H%M%S)"_"${CURRENT_BRANCH_NAME}"_diff.patch"

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
    --file   -f       file name
EOF
}

function exec {
  DIFF=""

  echo "current branch : "${CURRENT_BRANCH_NAME}
  echo "output : "${OUTPUT}"/"${FILE_NAME}
  if [ ! -e ${OUTPUT} ]; then
    mkdir -p ${OUTPUT}
  fi
   
  git diff --no-prefix ${DIFF} > ${OUTPUT}"/"${FILE_NAME}
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
    --file|-f)
      FILE_NAME=${2}
      shift
      ;;
  esac
  shift
done

# COMMAND
case ${SUB_COMMAND} in
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
