#!/bin/bash
#
array=(101 102 103)
var=104
echo ${array[@]}

function is_exist {
  local target=$1
  shift
  local arr=("$@")

  for item in "${arr[@]}"; do
    if [ "$item" == "$target" ]; then
      return 0
    fi
  done

  return 1
}

is_exist ${var} ${array[@]} 
if [[ $? -eq 0 ]]; then
  echo "Yes"
else
  echo "no"
fi
strvar='"102"'
is_exist ${strvar} ${array[@]} 
if [[ $? -eq 0 ]]; then
  echo "Yes"
else
  echo "no"
fi


DATEVAR=`date +%H`
echo $DATEVAR
DATESTR="$DATEVAR"
if [ ${DATEVAR:0:1} -eq 0 ]; then 
  echo "first is zero"
  retlen=$((${#DATESTR}-1))
  DATASTR1=${DATESTR:1:retlen}
  echo $DATASTR1
  DATESTR=$DATASTR1
fi
DATE=$((DATESTR))
echo $DATE

responsecode='"3"'
retlen=$((${#responsecode}-2))
retcode=${responsecode:1:retlen}
echo ${responsecode}
echo ${retcode}
